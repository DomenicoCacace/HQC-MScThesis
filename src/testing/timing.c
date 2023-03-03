/**
 * @file ttest.c
 * @brief Measure Welch's T for multiplication, PKE and KEM functions
 */

#include "architecture_detect.h"

#if MODE == TIMING

#include <string.h> // memcmp

#include "api.h"
#include "gf2x.h"
#include "hqc.h"
#include "main.h"
#include "parameters.h"
#include "shake_ds.h"
#include "shares.h"
#include "timing_tools.h"
#include "vector.h"


void FULL_KEM(void);

void FULL_PKE(void);

void MULT(void);

void ENC(void);

void DEC(void);

void ENCAPS(void);

void DECAPS(void);

void KEYGEN(void);


uint32_t start, end;

int run(int reps) {   
    welford_t timer;
    welford_init(&timer);
    
    TRIGGER_SET
    for(int i = 0; i < reps; i++) {
        ALG();
        welford_update(&timer, (long double)(end-start));
    }
    TRIGGER_RESET
    welford_print(timer);
    PRINTF("DONE\n");
    return 0;
}

void FULL_KEM(void) {
    unsigned char pk[PUBLIC_KEY_BYTES];
    unsigned char sk[SECRET_KEY_BYTES];
    unsigned char ct[CIPHERTEXT_BYTES];
    unsigned char key1[SHARED_SECRET_BYTES];
    unsigned char key2[SHARED_SECRET_BYTES];

    crypto_kem_keypair(pk, sk);

    start = get_systick();
    crypto_kem_enc(ct, key1, pk);
    crypto_kem_dec(key2, ct, sk);
    end = get_systick();
}

void FULL_PKE(void) {
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

    hqc_pke_keygen(pk, sk);
    vect_set_random_from_prng(m_in);
    randombytes((uint8_t *)salt, SALT_SIZE_BYTES);
    memcpy(tmp, m_in, VEC_K_SIZE_BYTES);
    memcpy(tmp + VEC_K_SIZE_BYTES, pk, SEED_BYTES);
    memcpy(tmp + VEC_K_SIZE_BYTES + SEED_BYTES, salt, SALT_SIZE_BYTES);
    shake256_512_ds(&shake256state, theta, tmp, VEC_K_SIZE_BYTES + SEED_BYTES + SALT_SIZE_BYTES, G_FCT_DOMAIN);
    
    start = get_systick();
    hqc_pke_encrypt(u, v, m_in, theta, pk);
    hqc_pke_decrypt(m_out, u, v, sk);
    end = get_systick();
}

void MULT(void) {
    #define MUL shares_vec_mul

    DIGIT u[VEC_N_SIZE_DIGIT] = {0};
    shares_n_t y;
    shares_n_t res;
    unsigned char sk[SECRET_KEY_BYTES];
    seedexpander_state seedexpander;

    shares_n_init(&y);
    shares_n_init(&res);
    randombytes(sk, SEED_BYTES);
    seedexpander_init(&seedexpander, sk, SEED_BYTES);
    vect_set_random_fixed_weight(&seedexpander, y.s0, PARAM_OMEGA);
    shares_init_from_data(&y, y.s0);
    vect_generate_random_for_mult(u);

    start = get_systick();
    MUL(&res, &y, u);
    end = get_systick();
}

void ENC(void) {
    DIGIT u[VEC_N_SIZE_DIGIT] = {0};
    DIGIT v[VEC_N1N2_SIZE_DIGIT] = {0};
    DIGIT m[VEC_K_SIZE_DIGIT] = {0};
    uint8_t theta[SHAKE256_512_BYTES] = {0};
    unsigned char pk[PUBLIC_KEY_BYTES];
    unsigned char sk[SECRET_KEY_BYTES];
    shake256incctx shake256state;
    DIGIT salt[SALT_SIZE_DIGIT] = {0};
    uint8_t tmp[VEC_K_SIZE_BYTES + SEED_BYTES + SALT_SIZE_BYTES] = {0};

    vect_set_random_from_prng(m);
    randombytes((uint8_t *)salt, SALT_SIZE_BYTES);
    memcpy(tmp, m, VEC_K_SIZE_BYTES);
    memcpy(tmp + VEC_K_SIZE_BYTES, pk, SEED_BYTES);
    memcpy(tmp + VEC_K_SIZE_BYTES + SEED_BYTES, salt, SALT_SIZE_BYTES);
    shake256_512_ds(&shake256state, theta, tmp, VEC_K_SIZE_BYTES + SEED_BYTES + SALT_SIZE_BYTES, G_FCT_DOMAIN);

    hqc_pke_keygen(pk, sk);

    start = get_systick();
    hqc_pke_encrypt(u, v, m, theta, pk);
    end = get_systick();
}

void DEC(void) {
    DIGIT u[VEC_N_SIZE_DIGIT] = {0};
    DIGIT v[VEC_N1N2_SIZE_DIGIT] = {0};
    DIGIT m[VEC_K_SIZE_DIGIT] = {0};
    uint8_t theta[SHAKE256_512_BYTES] = {0};   
    unsigned char pk[PUBLIC_KEY_BYTES];
    unsigned char sk[SECRET_KEY_BYTES];
    shake256incctx shake256state;

    hqc_pke_keygen(pk, sk);
    vect_set_random_from_prng(m);
    shake256_512_ds(&shake256state, theta, (uint8_t*) m, VEC_K_SIZE_BYTES, G_FCT_DOMAIN);
    hqc_pke_encrypt(u, v, m, theta, pk);

    start = get_systick();
    hqc_pke_decrypt(m, u, v, sk);
    end = get_systick();
}

void ENCAPS(void) {
    unsigned char pk[PUBLIC_KEY_BYTES];
    unsigned char sk[SECRET_KEY_BYTES];
    unsigned char ct[CIPHERTEXT_BYTES];
    unsigned char key[SHARED_SECRET_BYTES];

    crypto_kem_keypair(pk, sk);

    start = get_systick();
    crypto_kem_enc(ct, key, pk);
    end = get_systick();
}

void DECAPS(void) {
    unsigned char pk[PUBLIC_KEY_BYTES];
    unsigned char sk[SECRET_KEY_BYTES];
    unsigned char ct[CIPHERTEXT_BYTES];
    unsigned char key[SHARED_SECRET_BYTES];

    crypto_kem_keypair(pk, sk);
    crypto_kem_enc(ct, key, pk);

    start = get_systick();
    crypto_kem_dec(key, ct, sk);
    end = get_systick();
}

void KEYGEN(void) {
    unsigned char pk[PUBLIC_KEY_BYTES];
    unsigned char sk[SECRET_KEY_BYTES];

    start = get_systick();
    crypto_kem_keypair(pk, sk);
    end = get_systick();
}

#endif