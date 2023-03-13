/**
 * @file ttest.c
 * @brief Measure Welch's T for multiplication, PKE and KEM functions
 */

#include "architecture_detect.h"

#if MODE == TTEST

#define ALG_CONST CONST(ALG)

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


void FULL_KEM(void);
void FULL_KEM_CONST(void);

void FULL_PKE(void);
void FULL_PKE_CONST(void);

#define MUL vect_mul
void MULT(void);
void MULT_CONST(void);

void ENC(void);
void ENC_CONST(void);

void DEC(void);
void DEC_CONST(void);

void ENCAPS(void);
void ENCAPS_CONST(void);

void DECAPS(void);
void DECAPS_CONST(void);


uint32_t start, end;

int crypto_kem_enc_const(unsigned char *ct, unsigned char *ss, const unsigned char *pk);

unsigned char pk_const[PUBLIC_KEY_BYTES] = {0};
unsigned char sk_const[SECRET_KEY_BYTES] = {0};
unsigned char ct_const[CIPHERTEXT_BYTES];
DIGIT m_const[VEC_K_SIZE_DIGIT] = {0};
uint8_t theta_const[SHAKE256_512_BYTES] = {0};
__m256i u_const[VEC_N_256_SIZE_64 >> 2] = {0};
DIGIT v_const[VEC_N1N2_SIZE_DIGIT] = {0};
__m256i y_const[VEC_N_256_SIZE_64 >> 2] = {0};
seedexpander_state seedexpander_const;


int run(int reps) {   
    welford_t timer, timer_const;
    welford_init(&timer);
    welford_init(&timer_const);
    
    // initialize constants
    unsigned char key1[SHARED_SECRET_BYTES];    // only used for crypto_kem_enc_const
    shake256incctx shake256state;

    crypto_kem_keypair(pk_const, sk_const);
    seedexpander_init(&seedexpander_const, sk_const, SEED_BYTES);
    vect_set_random_from_prng(m_const);
    shake256_512_ds(&shake256state, theta_const, (uint8_t*) m_const, VEC_K_SIZE_BYTES, G_FCT_DOMAIN);
    hqc_pke_encrypt(u_const, v_const, m_const, theta_const, pk_const);
    vect_set_random_fixed_weight(&seedexpander_const, y_const, PARAM_OMEGA);
    crypto_kem_enc(ct_const, key1, pk_const);

    TRIGGER_SET
    ALG();
    for(int i = 0; i < reps; i++) {
        ALG();
        welford_update(&timer, (long double)(end-start));
    }
    ALG_CONST();
    for(int i = 0; i < reps; i++) {
        ALG_CONST();
        welford_update(&timer_const, (long double)(end-start));
    }
    TRIGGER_RESET
    welch_t_print(timer, timer_const);
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

void FULL_KEM_CONST(void) {
    unsigned char ct[CIPHERTEXT_BYTES];
    unsigned char key1[SHARED_SECRET_BYTES];
    unsigned char key2[SHARED_SECRET_BYTES];

    start = get_systick();
    crypto_kem_enc(ct, key1, pk_const);
    crypto_kem_dec(key2, ct, sk_const);
    end = get_systick();
}


void FULL_PKE(void) {
    unsigned char pk[PUBLIC_KEY_BYTES];
    unsigned char sk[SECRET_KEY_BYTES];
    DIGIT m_in[VEC_K_SIZE_DIGIT] = {0};
    DIGIT m_out[VEC_K_SIZE_DIGIT] = {0};
    uint8_t theta[SHAKE256_512_BYTES] = {0};
    __m256i u[VEC_N_256_SIZE_64 >> 2] = {0};
    DIGIT v[VEC_N1N2_SIZE_DIGIT] = {0};
    shake256incctx shake256state;

    vect_set_random_from_prng(m_in);
    shake256_512_ds(&shake256state, theta, (uint8_t*) m_in, VEC_K_SIZE_BYTES, G_FCT_DOMAIN);

    hqc_pke_keygen(pk, sk);

    start = get_systick();
    hqc_pke_encrypt(u, v, m_in, theta, pk);
    hqc_pke_decrypt(m_out, u, v, sk);
    end = get_systick();
}

void FULL_PKE_CONST(void) {
    DIGIT m_out[VEC_K_SIZE_DIGIT] = {0};
    __m256i u[VEC_N_256_SIZE_64 >> 2] = {0};
    DIGIT v[VEC_N1N2_SIZE_DIGIT] = {0};

    start = get_systick();
    hqc_pke_encrypt(u, v, m_const, theta_const, pk_const);
    hqc_pke_decrypt(m_out, u, v, sk_const);
    end = get_systick();
}

void MULT(void) {
    __m256i u[VEC_N_256_SIZE_64 >> 2] = {0};
    __m256i y[VEC_N_256_SIZE_64 >> 2] = {0};
    __m256i res[VEC_N_256_SIZE_64 >> 2] = {0};
    unsigned char sk[SECRET_KEY_BYTES];
    seedexpander_state seedexpander;

    randombytes(sk, SEED_BYTES);
    seedexpander_init(&seedexpander, sk, SEED_BYTES);
    vect_set_random_fixed_weight(&seedexpander, y, PARAM_OMEGA);
    vect_set_random_from_prng((uint64_t *) u);

    start = get_systick();
    MUL(res, y, u);
    end = get_systick();
}

void MULT_CONST(void) {
    __m256i u[VEC_N_256_SIZE_64 >> 2] = {0};
    __m256i y[VEC_N_256_SIZE_64 >> 2] = {0};
    __m256i res[VEC_N_256_SIZE_64 >> 2] = {0};
    unsigned char sk[SECRET_KEY_BYTES];
    seedexpander_state seedexpander;

    randombytes(sk, SEED_BYTES);
    seedexpander_init(&seedexpander, sk, SEED_BYTES);
    vect_set_random_fixed_weight(&seedexpander, y, PARAM_OMEGA);
    vect_set_random_from_prng((uint64_t *) u);

    start = get_systick();
    MUL(res, y_const, u_const);
    end = get_systick();
}

void ENC(void) {
    __m256i u[VEC_N_256_SIZE_64 >> 2] = {0};
    DIGIT v[VEC_N1N2_SIZE_DIGIT] = {0};
    DIGIT m[VEC_K_SIZE_DIGIT] = {0};
    uint8_t theta[SHAKE256_512_BYTES] = {0};
    unsigned char pk[PUBLIC_KEY_BYTES];
    unsigned char sk[SECRET_KEY_BYTES];
    shake256incctx shake256state;

    vect_set_random_from_prng(m);
    shake256_512_ds(&shake256state, theta, (uint8_t*) m, VEC_K_SIZE_BYTES, G_FCT_DOMAIN);
    hqc_pke_keygen(pk, sk);

    start = get_systick();
    hqc_pke_encrypt(u, v, m, theta, pk);
    end = get_systick();
}

void ENC_CONST(void) {
    __m256i u[VEC_N_256_SIZE_64 >> 2] = {0};
    DIGIT v[VEC_N1N2_SIZE_DIGIT] = {0};

    start = get_systick();
    hqc_pke_encrypt(u, v, m_const, theta_const, pk_const);
    end = get_systick();
}

void DEC(void) {
    __m256i u[VEC_N_256_SIZE_64 >> 2] = {0};
    DIGIT v[VEC_N1N2_SIZE_DIGIT] = {0};
    DIGIT m[VEC_K_SIZE_DIGIT] = {0};
    uint8_t theta[SHAKE256_512_BYTES] = {0};   
    unsigned char pk[PUBLIC_KEY_BYTES];
    unsigned char sk[SECRET_KEY_BYTES];
    shake256incctx shake256state;

    hqc_pke_keygen(pk, sk);
    vect_set_random_from_prng(m);
    shake256_512_ds(&shake256state, theta, (uint8_t*) m, VEC_K_SIZE_BYTES, G_FCT_DOMAIN);
    hqc_pke_encrypt(u, v, m, theta, sk);

    start = get_systick();
    hqc_pke_decrypt(m, u, v, sk);
    end = get_systick();
}

void DEC_CONST(void) {
    DIGIT m[VEC_K_SIZE_DIGIT] = {0};
    hqc_pke_encrypt(u_const, v_const, m_const, theta_const, pk_const);


    start = get_systick();
    hqc_pke_decrypt(m, u_const, v_const, sk_const);
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

void ENCAPS_CONST(void) {
    unsigned char ct[CIPHERTEXT_BYTES];
    unsigned char key[SHARED_SECRET_BYTES];

    start = get_systick();
    crypto_kem_enc(ct, key, pk_const);
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

void DECAPS_CONST(void) {
    unsigned char key[SHARED_SECRET_BYTES];

    start = get_systick();
    crypto_kem_dec(key, ct_const, sk_const);
    end = get_systick();
}

#endif
