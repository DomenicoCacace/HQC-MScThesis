/**
 * @file ttest.c
 * @brief Measure Welch's T for multiplication, PKE and KEM functions
 */

#include "architecture_detect.h"

#if MODE == TIMING_FAST

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


int run(int reps) {
    uint32_t t0,t1,t2,t3;
    unsigned char pk[PUBLIC_KEY_BYTES];
    unsigned char sk[SECRET_KEY_BYTES];

    TRIGGER_SET
#ifdef FULL_KEM
    welford_t encaps, decaps, kem;
    welford_init(&encaps);
    welford_init(&decaps);
    welford_init(&kem);
    for(int i = 0; i < reps; i++) {
        unsigned char ct[CIPHERTEXT_BYTES];
        unsigned char key1[SHARED_SECRET_BYTES];
        unsigned char key2[SHARED_SECRET_BYTES];

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
    PRINTF("kem: ");
    welford_print(kem);
    PRINTF("encaps: ");
    welford_print(encaps);
    PRINTF("decaps: ");
    welford_print(decaps);
#endif
#ifdef FULL_PKE
    welford_t enc, dec, pke, keygen;
    welford_init(&enc);
    welford_init(&dec);
    welford_init(&pke);
    welford_init(&keygen); 
    for(int i = 0; i < reps; i++) {
        DIGIT u[VEC_N_SIZE_DIGIT] = {0};
        DIGIT v[VEC_N1N2_SIZE_DIGIT] = {0};
        DIGIT m[VEC_K_SIZE_DIGIT] = {0};
        uint8_t theta[SHAKE256_512_BYTES] = {0};   
        shake256incctx shake256state;

        vect_set_random_from_prng(m);
        shake256_512_ds(&shake256state, theta, (uint8_t*) m, VEC_K_SIZE_BYTES, G_FCT_DOMAIN);

        t0 = get_systick();
        hqc_pke_keygen(pk, sk);
        t1 = get_systick();
        hqc_pke_encrypt(u, v, m, theta, pk);
        t2 = get_systick();
        hqc_pke_decrypt(m, u, v, sk);
        t3 = get_systick();

        welford_update(&keygen, t1-t0);
        welford_update(&enc, t2-t1);
        welford_update(&dec, t3-t2);
        welford_update(&pke, t3-t1);
    }
    PRINTF("pke: ");
    welford_print(pke);
    PRINTF("enc: ");
    welford_print(enc);
    PRINTF("dec: ");
    welford_print(dec);
    PRINTF("keygen: ");
    welford_print(keygen);
#endif
#ifdef MULT
    welford_t mult;
    welford_init(&mult);
    for(int i = 0; i < reps; i++) {
        DIGIT u[VEC_N_SIZE_DIGIT] = {0};
        DIGIT y[VEC_N_SIZE_DIGIT] = {0};
        DIGIT res[VEC_N_SIZE_DIGIT] = {0};
        unsigned char sk[SECRET_KEY_BYTES];
        seedexpander_state seedexpander;

        randombytes(sk, SEED_BYTES);
        seedexpander_init(&seedexpander, sk, SEED_BYTES);
        vect_generate_random_for_mult(u);
        vect_set_random_fixed_weight(&seedexpander, y, PARAM_OMEGA);

        t0 = get_systick();
        kar_mul(res, y, u);
        t1 = get_systick();

        welford_update(&mult, t1-t0);
    }
    PRINTF("mul: ");
    welford_print(mult);
#endif
    TRIGGER_RESET
    PRINTF("DONE\n");
    return 0;
}
#endif
