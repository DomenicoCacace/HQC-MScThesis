/**
 * @file functional.c
 * @brief Functional tests for multiplication, PKE and KEM functions
 */

#include "architecture_detect.h"

#if MODE == FUNCTIONAL

#include <string.h> // memcmp

#include "api.h"
#include "gf2x.h"
#include "hqc.h"
#include "main.h"
#include "shake_ds.h"
#include "vector.h"


int FULL_KEM(void);

int FULL_PKE(void);

int MULT(void);


int run(int reps) {
    int passed = 0;
    TRIGGER_SET
    for(int i = 0; i < reps; i++) 
        passed += ALG();
    TRIGGER_RESET
    PRINTF("Passed/Total: %d/%d\n\n", passed, reps);  

    return reps-passed;
}

int FULL_KEM(void) {
    unsigned char pk[PUBLIC_KEY_BYTES];
    unsigned char sk[SECRET_KEY_BYTES];
    unsigned char ct[CIPHERTEXT_BYTES];
    unsigned char key1[SHARED_SECRET_BYTES];
    unsigned char key2[SHARED_SECRET_BYTES];

    crypto_kem_keypair(pk, sk);
    crypto_kem_enc(ct, key1, pk);
    crypto_kem_dec(key2, ct, sk);

    if (memcmp(key1, key2, SHARED_SECRET_BYTES) == 0)
        return 1;
    return 0; 
}

int FULL_PKE(void) {
    unsigned char pk[PUBLIC_KEY_BYTES];
    unsigned char sk[SECRET_KEY_BYTES];
    DIGIT m_in[VEC_K_SIZE_DIGIT] = {0};
    DIGIT m_out[VEC_K_SIZE_DIGIT] = {0};
    uint8_t sigma[VEC_K_SIZE_BYTES] = {0};
    uint8_t theta[SHAKE256_512_BYTES] = {0};
    DIGIT u[VEC_N_SIZE_DIGIT] = {0};
    DIGIT v[VEC_N1N2_SIZE_DIGIT] = {0};
    shake256incctx shake256state;

    vect_set_random_from_prng(m_in);
    shake256_512_ds(&shake256state, theta, (uint8_t*) m_in, VEC_K_SIZE_BYTES, G_FCT_DOMAIN);
    
    hqc_pke_keygen(pk, sk);
    hqc_pke_encrypt(u, v, m_in, theta, pk);
    hqc_pke_decrypt(m_out, sigma, u, v, sk);

    if (memcmp(m_in, m_out, VEC_K_SIZE_BYTES) == 0)
        return 1;
    return 0;
}

int MULT(void) {
    #define MUL_ORIGINAL vect_mul
    #define MUL_OPTIMIZED opt_mul

    uint64_t u[VEC_N_SIZE_64] = {0};
    uint32_t y[PARAM_OMEGA] = {0};
    DIGIT y_dense[VEC_N_SIZE_DIGIT] = {0};
    uint64_t res_original[VEC_N_SIZE_64] = {0};
    DIGIT res_optimized[VEC_N_SIZE_64] = {0};
    unsigned char sk[SECRET_KEY_BYTES];
    seedexpander_state seedexpander;

    randombytes(sk, SEED_BYTES);
    seedexpander_init(&seedexpander, sk, SEED_BYTES);
    vect_set_random_fixed_weight_by_coordinates(&seedexpander, y, PARAM_OMEGA);
    vect_sparse_to_dense(y_dense, y, PARAM_OMEGA);
    vect_generate_random_for_mult(u);

    MUL_ORIGINAL(res_original, y, u, PARAM_OMEGA, &seedexpander);
    MUL_OPTIMIZED(res_optimized, y_dense, u);

    if (memcmp(res_original, res_optimized, VEC_N_SIZE_BYTES) == 0)
        return 1;
    return 0;
}

#endif
