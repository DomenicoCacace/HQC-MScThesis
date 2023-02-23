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


int crypto_kem_enc_const(unsigned char *ct, unsigned char *ss, const unsigned char *pk);

unsigned char pk_const[PUBLIC_KEY_BYTES] = {0};
unsigned char sk_const[SECRET_KEY_BYTES] = {0};
DIGIT m_const[VEC_K_SIZE_DIGIT] = {0};

#ifdef FULL_PKE
int run(int reps) {   
    // initialize constants
    seedexpander_state seedexpander_const;

    crypto_kem_keypair(pk_const, sk_const);
    seedexpander_init(&seedexpander_const, sk_const, SEED_BYTES);
    vect_set_random_from_prng(m_const);

    uint32_t t1,t2,t3;
    welford_t enc, enc_const;
    welford_init(&enc);
    welford_init(&enc_const);
    welford_t dec, dec_const;
    welford_init(&dec);
    welford_init(&dec_const);
    welford_t pke, pke_const;
    welford_init(&pke);
    welford_init(&pke_const);

    unsigned char pk[PUBLIC_KEY_BYTES];
    unsigned char sk[SECRET_KEY_BYTES];
    DIGIT m_in[VEC_K_SIZE_DIGIT] = {0};
    DIGIT m_out[VEC_K_SIZE_DIGIT] = {0};
    uint8_t theta[SHAKE256_512_BYTES] = {0};
    DIGIT u[VEC_N_SIZE_DIGIT] = {0};
    DIGIT v[VEC_N1N2_SIZE_DIGIT] = {0};
    shake256incctx shake256state;

    TRIGGER_SET
    for(int i = 0; i < reps; i++) {


        //----------PKE--------------

        hqc_pke_keygen(pk, sk);
        vect_set_random_from_prng(m_in);
        shake256_512_ds(&shake256state, theta, (uint8_t *)m_in, VEC_K_SIZE_BYTES, G_FCT_DOMAIN);

        t1 = get_systick();
        hqc_pke_encrypt(u, v, m_in, theta, pk);
        t2 = get_systick();
        hqc_pke_decrypt(m_out, u, v, sk);
        t3 = get_systick();
        welford_update(&enc, t2-t1);
        welford_update(&dec, t3-t2);
        welford_update(&pke, t3-t1);
    }
    for(int i = 0; i < reps; i++) {
        shake256_512_ds(&shake256state, theta, (uint8_t *)m_const, VEC_K_SIZE_BYTES, G_FCT_DOMAIN);

        t1 = get_systick();
        hqc_pke_encrypt(u, v, m_const, theta, pk_const);
        t2 = get_systick();
        hqc_pke_decrypt(m_out, u, v, sk_const);
        t3 = get_systick();
        welford_update(&enc_const, t2-t1);
        welford_update(&dec_const, t3-t2);
        welford_update(&pke_const, t3-t1);
    }
    
    TRIGGER_RESET
    PRINTF("enc: ");
    welch_t_print(enc, enc_const);
    PRINTF("dec: ");
    welch_t_print(dec, dec_const);
    PRINTF("pke: ");
    welch_t_print(pke, pke_const);
    PRINTF("DONE\n");
    return 0;
}
#else
int run(int reps) {
    // initialize constants
    crypto_kem_keypair(pk_const, sk_const);

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

    for(int i = 0; i < reps; i++) {
        t1 = get_systick();
        crypto_kem_enc_const(ct, key1, pk_const);
        t2 = get_systick();
        crypto_kem_dec(key2, ct, sk_const);
        t3 = get_systick();

        welford_update(&encaps_const, t2-t1);
        welford_update(&decaps_const, t3-t2);
        welford_update(&kem_const, t3-t1);
    }
    TRIGGER_RESET
    PRINTF("encaps: ");
    welch_t_print(encaps, encaps_const);
    PRINTF("decaps: ");
    welch_t_print(decaps, decaps_const);
    PRINTF("kem: ");
    welch_t_print(kem, kem_const);
    PRINTF("DONE\n");
    return 0;
}
#endif
int crypto_kem_enc_const(unsigned char *ct, unsigned char *ss, const unsigned char *pk) {
    uint8_t theta[SHAKE256_512_BYTES] = {0};
    DIGIT m[VEC_K_SIZE_DIGIT] = {0};
    DIGIT u[VEC_N_SIZE_DIGIT] = {0};
    DIGIT v[VEC_N1N2_SIZE_DIGIT] = {0};
    uint8_t d[SHAKE256_512_BYTES] = {0};
    uint8_t mc[VEC_K_SIZE_BYTES + VEC_N_SIZE_BYTES + VEC_N1N2_SIZE_BYTES] = {0};
    shake256incctx shake256state;

    // Computing m
    vect_set_random_from_prng(m);   // unused, but needed to mimick the original function

    // Computing theta
    shake256_512_ds(&shake256state, theta, (uint8_t *) m_const, VEC_K_SIZE_BYTES, G_FCT_DOMAIN);

    // Encrypting m
    hqc_pke_encrypt(u, v, m_const, theta, pk);

    // Computing d
    shake256_512_ds(&shake256state, d, (uint8_t *) m_const, VEC_K_SIZE_BYTES, H_FCT_DOMAIN);

    // Computing shared secret
    memcpy(mc, m_const, VEC_K_SIZE_BYTES);
    memcpy(mc + VEC_K_SIZE_BYTES, u, VEC_N_SIZE_BYTES);
    memcpy(mc + VEC_K_SIZE_BYTES + VEC_N_SIZE_BYTES, v, VEC_N1N2_SIZE_BYTES);
    shake256_512_ds(&shake256state, ss, mc, VEC_K_SIZE_BYTES + VEC_N_SIZE_BYTES + VEC_N1N2_SIZE_BYTES, K_FCT_DOMAIN);

    // Computing ciphertext
    hqc_ciphertext_to_string(ct, u, v, d);
    return 0;
}

#endif

