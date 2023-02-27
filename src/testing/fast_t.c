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


#ifdef FULL_PKE
int run(int reps) {   
    uint32_t t1,t2,t3,t4,t5;
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
    TRIGGER_SET
    for(int i = 0; i < reps; i++) {
        hqc_pke_keygen(pk, sk);
        vect_set_random_from_prng(m);
        shake256_512_ds(&shake256state, theta_const, m_const, VEC_K_SIZE_BYTES, G_FCT_DOMAIN);
        shake256_512_ds(&shake256state, theta, m, VEC_K_SIZE_BYTES, G_FCT_DOMAIN);

        t1 = get_systick();
        hqc_pke_encrypt(u, v, m, theta, pk);
        t2 = get_systick();
        hqc_pke_encrypt(u_const, v_const, m_const, theta_const, pk_const);
        t3 = get_systick();
        hqc_pke_decrypt(m_const, u_const, v_const, sk_const);
        t4 = get_systick();
        hqc_pke_decrypt(m, u, v, sk);
        t5 = get_systick();

        welford_update(&enc, t2-t1);
        welford_update(&enc_const, t3-t2);
        welford_update(&dec, t4-t3);
        welford_update(&dec_const, t5-t4);
        welford_update(&pke, t4-t1-(t3-t2));
        welford_update(&pke_const, t5-t2-(t4-t3));

        memset(m, 0, VEC_K_SIZE_BYTES);
        memset(theta, 0, SHAKE256_512_BYTES);
        memset(u, 0, VEC_N_SIZE_BYTES);
        memset(v, 0, VEC_N1N2_SIZE_BYTES);
        memset(pk, 0, PUBLIC_KEY_BYTES);
        memset(sk, 0, SECRET_KEY_BYTES);
        memset(theta_const, 0, SHAKE256_512_BYTES);
        memset(u_const, 0, VEC_N_SIZE_BYTES);
        memset(v_const, 0, VEC_N1N2_SIZE_BYTES);
    }
    
    TRIGGER_RESET
    PRINTF("pke: ");
    PRINTF("%Lf %Lf %Lf ", pke.mean-pke_const.mean, pke.M2, pke_const.M2);
    welch_t_print(pke, pke_const);
    PRINTF("enc: ");
    PRINTF("%Lf %Lf %Lf ", enc.mean-enc_const.mean, enc.M2, enc_const.M2);
    welch_t_print(enc, enc_const);
    PRINTF("dec: ");
    PRINTF("%Lf %Lf %Lf ", dec.mean-dec_const.mean, dec.M2, dec_const.M2);
    welch_t_print(dec, dec_const);

    PRINTF("DONE\n");
    return 0;
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

    DIGIT u[VEC_N_SIZE_DIGIT] = {0};
    DIGIT y[VEC_N_SIZE_DIGIT] = {0};
    DIGIT u_const[VEC_N_SIZE_DIGIT] = {0};
    DIGIT y_const[VEC_N_SIZE_DIGIT] = {0};
    DIGIT res[VEC_N_SIZE_DIGIT] = {0};
    seedexpander_state seedexpander;
    uint8_t seed[SEED_BYTES] = {0};


    TRIGGER_SET
    for(int i = 0; i < reps; i++) {
        randombytes(seed, SEED_BYTES);
        seedexpander_init(&seedexpander, seed, SEED_BYTES);
        vect_set_random_fixed_weight(&seedexpander, y, PARAM_OMEGA);
        vect_generate_random_for_mult(u);

        t1 = get_systick();
        opt_mul(res, u, y);
        t2 = get_systick();

        welford_update(&mul, t2-t1);
    }

    vect_set_random_fixed_weight(&seedexpander, y_const, PARAM_OMEGA);
    vect_generate_random_for_mult(u_const);
    for(int i = 0; i < reps; i++) {
        //randombytes(seed, SEED_BYTES);
        //seedexpander_init(&seedexpander, seed, SEED_BYTES);
        vect_set_random_fixed_weight(&seedexpander, y, PARAM_OMEGA);
        vect_generate_random_for_mult(u);

        t1 = get_systick();
        opt_mul(res, y_const, u_const);
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

