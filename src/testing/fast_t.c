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

    DIGIT m_const[VEC_K_SIZE_DIGIT] = {0};    
    vect_set_random_from_prng(m_const);

    unsigned char pk[PUBLIC_KEY_BYTES];
    unsigned char sk[SECRET_KEY_BYTES];
    DIGIT m_in[VEC_K_SIZE_DIGIT] = {0};
    DIGIT m_out[VEC_K_SIZE_DIGIT] = {0};
    uint8_t theta[SHAKE256_512_BYTES] = {0};
    DIGIT u[VEC_N_SIZE_DIGIT] = {0};
    DIGIT v[VEC_N1N2_SIZE_DIGIT] = {0};
    shake256incctx shake256state;
    DIGIT salt[SALT_SIZE_DIGIT] = {0};
    uint8_t tmp[VEC_K_SIZE_BYTES + SEED_BYTES + SALT_SIZE_BYTES] = {0};


    TRIGGER_SET
    for(int i = 0; i < reps; i++) {
        hqc_pke_keygen(pk, sk);
        vect_set_random_from_prng(m_in);
        randombytes((uint8_t *)salt, SALT_SIZE_BYTES);
        memcpy(tmp, m_in, VEC_K_SIZE_BYTES);
        memcpy(tmp + VEC_K_SIZE_BYTES, pk, SEED_BYTES);
        memcpy(tmp + VEC_K_SIZE_BYTES + SEED_BYTES, salt, SALT_SIZE_BYTES);
        shake256_512_ds(&shake256state, theta, tmp, VEC_K_SIZE_BYTES + SEED_BYTES + SALT_SIZE_BYTES, G_FCT_DOMAIN);


        t1 = get_systick();
        hqc_pke_encrypt(u, v, m_in, theta, pk);
        t2 = get_systick();
        hqc_pke_decrypt(m_out, u, v, sk);
        t3 = get_systick();
        welford_update(&enc, t2-t1);
        welford_update(&dec, t3-t2);
        welford_update(&pke, t3-t1);
    }

    hqc_pke_keygen(pk, sk);
    for(int i = 0; i < reps; i++) {
        randombytes((uint8_t *)salt, SALT_SIZE_BYTES);
        memcpy(tmp, m_const, VEC_K_SIZE_BYTES);
        memcpy(tmp + VEC_K_SIZE_BYTES, pk, SEED_BYTES);
        memcpy(tmp + VEC_K_SIZE_BYTES + SEED_BYTES, salt, SALT_SIZE_BYTES);
        shake256_512_ds(&shake256state, theta, tmp, VEC_K_SIZE_BYTES + SEED_BYTES + SALT_SIZE_BYTES, G_FCT_DOMAIN);


        t1 = get_systick();
        hqc_pke_encrypt(u, v, m_const, theta, pk);
        t2 = get_systick();
        hqc_pke_decrypt(m_out, u, v, sk);
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

#endif

