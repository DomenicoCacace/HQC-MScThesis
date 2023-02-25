/**
 * @file ttest.c
 * @brief Measure Welch's T for multiplication, PKE and KEM functions
 */

#include "architecture_detect.h"

#if MODE == TTEST_FAST

#include <string.h> // memcmp

#include "api.h"
#include "gf2x.h"
#include "hqc.h"
#include "main.h"
#include "parameters.h"
#include "parsing.h"
#include "shake_ds.h"
#include "timing_tools.h"
#include "vector.h"

uint32_t t0,t1,t2,t3;

#ifdef FULL_PKE
int run(int reps) {   
    welford_t enc, enc_const;
    welford_init(&enc);
    welford_init(&enc_const);
    welford_t dec, dec_const;
    welford_init(&dec);
    welford_init(&dec_const);
    welford_t pke, pke_const;
    welford_init(&pke);
    welford_init(&pke_const);

    unsigned char pk_const[PUBLIC_KEY_BYTES];
    unsigned char sk_const[SECRET_KEY_BYTES];
    DIGIT m_const[VEC_K_SIZE_DIGIT] = {0};
    uint8_t theta_const[SHAKE256_512_BYTES] = {0};
    DIGIT u_const[VEC_N_SIZE_DIGIT] = {0};
    DIGIT v_const[VEC_N1N2_SIZE_DIGIT] = {0};

    unsigned char pk[PUBLIC_KEY_BYTES];
    unsigned char sk[SECRET_KEY_BYTES];
    DIGIT m[VEC_K_SIZE_DIGIT] = {0};    
    uint8_t theta[SHAKE256_512_BYTES] = {0};
    DIGIT u[VEC_N_SIZE_DIGIT] = {0};
    DIGIT v[VEC_N1N2_SIZE_DIGIT] = {0};
    
    shake256incctx shake256state;

    hqc_pke_keygen(pk_const, sk_const);
    vect_set_random_from_prng(m_const);
    shake256_512_ds(&shake256state, theta_const, (uint8_t *)m_const, VEC_K_SIZE_BYTES, G_FCT_DOMAIN);        
    TRIGGER_SET
    for(int i = 0; i < reps; i++) {
        hqc_pke_keygen(pk, sk);
        vect_set_random_from_prng(m);
        shake256_512_ds(&shake256state, theta, (uint8_t *)m, VEC_K_SIZE_BYTES, G_FCT_DOMAIN);

        hqc_pke_encrypt_probe(u, v, m, theta, pk);
        hqc_pke_decrypt_probe(m, u, v, sk);
        welford_update(&pke, t3-t2+t1-t0);
        welford_update(&enc, t1-t0);
        welford_update(&dec, t3-t2);

        hqc_pke_encrypt_probe(u_const, v_const, m_const, theta_const, pk_const);
        hqc_pke_decrypt_probe(m_const, u_const, v_const, sk_const);
        welford_update(&pke_const, t3-t2+t1-t0);
        welford_update(&enc_const, t1-t0);
        welford_update(&dec_const, t3-t2);
    }
    
    TRIGGER_RESET
    PRINTF("pke: ");
    welch_t_print(pke, pke_const);
    PRINTF("enc: ");
    welch_t_print(enc, enc_const);
    PRINTF("dec: ");
    welch_t_print(dec, dec_const);
    PRINTF("DONE\n");
    return 0;
}

void hqc_pke_encrypt_probe(DIGIT *u, DIGIT *v, DIGIT *m, unsigned char *theta, const unsigned char *pk) {
    seedexpander_state seedexpander;
    DIGIT h[VEC_N_SIZE_DIGIT] = {0};
    DIGIT s[VEC_N_SIZE_DIGIT] = {0};
    DIGIT r1[VEC_N_SIZE_DIGIT] = {0};
    uint32_t r2[PARAM_OMEGA_R] = {0};
    DIGIT e[VEC_N_SIZE_DIGIT] = {0};
    DIGIT tmp1[VEC_N_SIZE_DIGIT] = {0};
    DIGIT tmp2[VEC_N_SIZE_DIGIT] = {0};

    uint8_t seed[PUBLIC_KEY_BYTES] = {0};

    randombytes(seed, PUBLIC_KEY_BYTES);
    seedexpander_init(&seedexpander, seed, PUBLIC_KEY_BYTES);
    hqc_public_key_from_string(h, s, seed);
    vect_set_random_fixed_weight(&seedexpander, e, PARAM_OMEGA_E);
    vect_set_random_fixed_weight(&seedexpander, r1, PARAM_OMEGA_R);
    vect_set_random_fixed_weight(&seedexpander, r2, PARAM_OMEGA_R);
    code_encode(v, seed);
    vect_resize(tmp1, PARAM_N, v, PARAM_N1N2);
    vect_add(tmp2, e, tmp1, VEC_N_SIZE_DIGIT);

    t0 = get_systick();
    // Create seed_expander from theta
    seedexpander_init(&seedexpander, theta, SEED_BYTES);

    // Retrieve h and s from public key
    hqc_public_key_from_string(h, s, pk);

    // Generate r1, r2 and e
    vect_set_random_fixed_weight(&seedexpander, e, PARAM_OMEGA_E);
    vect_set_random_fixed_weight(&seedexpander, r1, PARAM_OMEGA_R);
    vect_set_random_fixed_weight_by_coordinates(&seedexpander, r2, PARAM_OMEGA_R);

    // Compute u = r1 + r2.h
    vect_mul(u, r2, h, PARAM_OMEGA_R, &seedexpander);
    vect_add(u, r1, u, VEC_N_SIZE_DIGIT);

    // Compute v = m.G by encoding the message
    code_encode(v, m);
    vect_resize(tmp1, PARAM_N, v, PARAM_N1N2);

    // Compute v = m.G + s.r2 + e
    vect_mul(tmp2, r2, s, PARAM_OMEGA_R, &seedexpander);
    vect_add(tmp2, e, tmp2, VEC_N_SIZE_DIGIT);
    vect_add(tmp2, tmp1, tmp2, VEC_N_SIZE_DIGIT);
    vect_resize(v, PARAM_N1N2, tmp2, PARAM_N);
    t1 = get_systick();
}

void hqc_pke_decrypt_probe(DIGIT *m, const DIGIT *u, const DIGIT *v, const unsigned char *sk) {
    DIGIT x[VEC_N_SIZE_DIGIT] = {0};
    uint32_t y[PARAM_OMEGA] = {0};
    uint8_t pk[PUBLIC_KEY_BYTES] = {0};
    DIGIT tmp1[VEC_N_SIZE_DIGIT] = {0};
    DIGIT tmp2[VEC_N_SIZE_DIGIT] = {0};
    seedexpander_state perm_seedexpander;
    uint8_t perm_seed[SEED_BYTES] = {0};
    uint8_t seed[SECRET_KEY_BYTES] = {0};
    
    randombytes(seed, SECRET_KEY_BYTES);
    hqc_secret_key_from_string(x, y, pk, seed);

    t2 = get_systick();
    // Retrieve x, y, pk from secret key
    hqc_secret_key_from_string(x, y, pk, sk);

    randombytes(perm_seed, SEED_BYTES);
    seedexpander_init(&perm_seedexpander, perm_seed, SEED_BYTES);

    // Compute v - u.y
    vect_resize(tmp1, PARAM_N, v, PARAM_N1N2);
    vect_mul(tmp2, y, u, PARAM_OMEGA, &perm_seedexpander);
    vect_add(tmp2, tmp1, tmp2, VEC_N_SIZE_DIGIT);

    // Compute m by decoding v - u.y
    code_decode(m, tmp2);
    t3 = get_systick();
}
#endif
#ifdef FULL_KEM
int run(int reps) {
    uint32_t t1,t2,t3;
    welford_t encaps, encaps_const;
    welford_init(&encaps);
    welford_init(&encaps_const);
    welford_t decaps, decaps_const;
    welford_init(&decaps);
    welford_init(&decaps_const);
    welford_t kem, kem_const;
    welford_init(&kem);
    welford_init(&kem_const);

    unsigned char pk[PUBLIC_KEY_BYTES];
    unsigned char sk[SECRET_KEY_BYTES];
    unsigned char ct[CIPHERTEXT_BYTES];
    unsigned char key1[SHARED_SECRET_BYTES];
    unsigned char key2[SHARED_SECRET_BYTES];
    
    TRIGGER_SET
    for(int i = 0; i < reps; i++) {
        crypto_kem_keypair(pk, sk);

        t1 = get_systick();
        crypto_kem_enc(ct, key1, pk);
        t2 = get_systick();
        crypto_kem_dec(key2, ct, sk);
        t3 = get_systick();

        welford_update(&encaps, t2-t1);
        welford_update(&decaps, t3-t2);
        welford_update(&kem, t3-t1);
    }

    crypto_kem_keypair(pk, sk);
    for(int i = 0; i < reps; i++) {
        t1 = get_systick();
        crypto_kem_enc(ct, key1, pk);
        t2 = get_systick();
        crypto_kem_dec(key2, ct, sk);
        t3 = get_systick();

        welford_update(&encaps_const, t2-t1);
        welford_update(&decaps_const, t3-t2);
        welford_update(&kem_const, t3-t1);
    }
    TRIGGER_RESET
    PRINTF("kem: ");
    welch_t_print(kem, kem_const);
    PRINTF("encaps: ");
    welch_t_print(encaps, encaps_const);
    PRINTF("decaps: ");
    welch_t_print(decaps, decaps_const);
    PRINTF("DONE\n");
    return 0;
}
#endif
#ifdef MULT
int run(int reps) {
    uint32_t t1,t2;
    welford_t mul, mul_const;
    welford_init(&mul);
    welford_init(&mul_const);

    DIGIT u_const[VEC_N_SIZE_DIGIT] = {0};
    uint32_t y_const[PARAM_OMEGA] = {0};

    DIGIT u[VEC_N_SIZE_DIGIT] = {0};
    uint32_t y[PARAM_OMEGA] = {0};
    DIGIT res[VEC_N_SIZE_DIGIT] = {0};
    seedexpander_state seedexpander;
    uint8_t seed[SEED_BYTES] = {0};

    TRIGGER_SET
    for(int i = 0; i < reps; i++) {
        randombytes(seed, SEED_BYTES);
        seedexpander_init(&seedexpander, seed, SEED_BYTES);
        vect_set_random_fixed_weight_by_coordinates(&seedexpander, y, PARAM_OMEGA);
        vect_generate_random_for_mult(u);

        t1 = get_systick();
        vect_mul(res, u, y, PARAM_OMEGA, &seedexpander);
        t2 = get_systick();

        welford_update(&mul, t2-t1);
    }

    randombytes(seed, SEED_BYTES);
    seedexpander_init(&seedexpander, seed, SEED_BYTES);
    vect_set_random_fixed_weight_by_coordinates(&seedexpander, y_const, PARAM_OMEGA);
    vect_generate_random_for_mult(u_const);
    for(int i = 0; i < reps; i++) {
        randombytes(seed, SEED_BYTES);
        seedexpander_init(&seedexpander, seed, SEED_BYTES);
        vect_set_random_fixed_weight(&seedexpander, y, PARAM_OMEGA);
        vect_generate_random_for_mult(u);

        t1 = get_systick();
        vect_mul(res, y_const, u_const, PARAM_OMEGA, &seedexpander);
        t2 = get_systick();

        welford_update(&mul_const, t2-t1);
    }
    TRIGGER_RESET
    PRINTF("mult: ");
    welch_t_print(mul, mul_const);
    PRINTF("DONE\n");
    return 0;
}
#endif

#endif

