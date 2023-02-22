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

#define MUL opt_mul
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
DIGIT m_const[VEC_K_SIZE_DIGIT] = {0};
DIGIT u_const[VEC_N_SIZE_DIGIT] = {0};
DIGIT y_const[VEC_N_SIZE_DIGIT] = {0};


int run(int reps) {   
    welford_t timer, timer_const;
    welford_init(&timer);
    welford_init(&timer_const);
    
    // initialize constants
    seedexpander_state seedexpander_const;
    crypto_kem_keypair(pk_const, sk_const);
    seedexpander_init(&seedexpander_const, sk_const, SEED_BYTES);
    vect_set_random_from_prng(m_const);
    vect_generate_random_for_mult(u_const);
    vect_set_random_fixed_weight(&seedexpander_const, y_const, PARAM_OMEGA);

    TRIGGER_SET
    for(int i = 0; i < reps; i++) {
        ALG();
        welford_update(&timer, (long double)(end-start));

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
    unsigned char pk[PUBLIC_KEY_BYTES];
    unsigned char sk[SECRET_KEY_BYTES];
    unsigned char ct[CIPHERTEXT_BYTES];
    unsigned char key1[SHARED_SECRET_BYTES];
    unsigned char key2[SHARED_SECRET_BYTES];

    memcpy(pk, pk_const, PUBLIC_KEY_BYTES);
    memcpy(sk, sk_const, SECRET_KEY_BYTES);

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

    vect_set_random_from_prng(m_in);
    shake256_512_ds(&shake256state, theta, (uint8_t*) m_in, VEC_K_SIZE_BYTES, G_FCT_DOMAIN);

    hqc_pke_keygen(pk, sk);

    start = get_systick();
    hqc_pke_encrypt(u, v, m_in, theta, pk);
    hqc_pke_decrypt(m_out, u, v, sk);
    end = get_systick();
}

void FULL_PKE_CONST(void) {
    unsigned char pk[PUBLIC_KEY_BYTES];
    unsigned char sk[SECRET_KEY_BYTES];
    DIGIT m_in[VEC_K_SIZE_DIGIT] = {0};
    DIGIT m_out[VEC_K_SIZE_DIGIT] = {0};
    uint8_t theta[SHAKE256_512_BYTES] = {0};
    DIGIT u[VEC_N_SIZE_DIGIT] = {0};
    DIGIT v[VEC_N1N2_SIZE_DIGIT] = {0};
    shake256incctx shake256state;

    memcpy(m_in, m_const, VEC_K_SIZE_BYTES);
    shake256_512_ds(&shake256state, theta, (uint8_t*) m_in, VEC_K_SIZE_BYTES, G_FCT_DOMAIN);

    memcpy(pk, pk_const, PUBLIC_KEY_BYTES);
    memcpy(sk, sk_const, SECRET_KEY_BYTES);

    start = get_systick();
    hqc_pke_encrypt(u, v, m_in, theta, pk);
    hqc_pke_decrypt(m_out, u, v, sk);
    end = get_systick();
}

void MULT(void) {
    DIGIT u[VEC_N_SIZE_DIGIT] = {0};
    DIGIT y[VEC_N_SIZE_DIGIT] = {0};
    DIGIT res[VEC_N_SIZE_DIGIT] = {0};
    unsigned char sk[SECRET_KEY_BYTES];
    seedexpander_state seedexpander;

    randombytes(sk, SEED_BYTES);
    seedexpander_init(&seedexpander, sk, SEED_BYTES);
    vect_set_random_fixed_weight(&seedexpander, y, PARAM_OMEGA);
    vect_generate_random_for_mult(u);

    start = get_systick();
    MUL(res, y, u);
    end = get_systick();
}

void MULT_CONST(void) {
    DIGIT u[VEC_N_SIZE_DIGIT] = {0};
    DIGIT y[VEC_N_SIZE_DIGIT] = {0};
    DIGIT res[VEC_N_SIZE_DIGIT] = {0};

    memcpy(y, y_const, VEC_N_SIZE_BYTES);
    memcpy(u, u_const, VEC_N_SIZE_BYTES);

    start = get_systick();
    MUL(res, y, u);
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

    vect_set_random_from_prng(m);
    shake256_512_ds(&shake256state, theta, (uint8_t*) m, VEC_K_SIZE_BYTES, G_FCT_DOMAIN);
    hqc_pke_keygen(pk, sk);

    start = get_systick();
    hqc_pke_encrypt(u, v, m, theta, pk);
    end = get_systick();
}

void ENC_CONST(void) {
    DIGIT u[VEC_N_SIZE_DIGIT] = {0};
    DIGIT v[VEC_N1N2_SIZE_DIGIT] = {0};
    DIGIT m[VEC_K_SIZE_DIGIT] = {0};
    uint8_t theta[SHAKE256_512_BYTES] = {0};
    unsigned char pk[PUBLIC_KEY_BYTES];
    shake256incctx shake256state;

    memcpy(m, m_const, VEC_K_SIZE_BYTES);
    memcpy(pk, pk_const, PUBLIC_KEY_BYTES);
    shake256_512_ds(&shake256state, theta, (uint8_t*) m, VEC_K_SIZE_BYTES, G_FCT_DOMAIN);

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

void DEC_CONST(void) {
    DIGIT u[VEC_N_SIZE_DIGIT] = {0};
    DIGIT v[VEC_N1N2_SIZE_DIGIT] = {0};
    DIGIT m[VEC_K_SIZE_DIGIT] = {0};
    uint8_t theta[SHAKE256_512_BYTES] = {0};   
    unsigned char pk[PUBLIC_KEY_BYTES];
    unsigned char sk[SECRET_KEY_BYTES];
    shake256incctx shake256state;

    memcpy(pk, pk_const, PUBLIC_KEY_BYTES);
    memcpy(sk, sk_const, SECRET_KEY_BYTES);
    memcpy(m, m_const, VEC_K_SIZE_BYTES);
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

void ENCAPS_CONST(void) {
    unsigned char pk[PUBLIC_KEY_BYTES];
    unsigned char ct[CIPHERTEXT_BYTES];
    unsigned char key[SHARED_SECRET_BYTES];
    
    memcpy(pk, pk_const, PUBLIC_KEY_BYTES);

    start = get_systick();
    crypto_kem_enc_const(ct, key, pk);
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
    unsigned char pk[PUBLIC_KEY_BYTES];
    unsigned char sk[SECRET_KEY_BYTES];
    unsigned char ct[CIPHERTEXT_BYTES];
    unsigned char key[SHARED_SECRET_BYTES];

    memcpy(pk, pk_const, PUBLIC_KEY_BYTES);
    memcpy(sk, sk_const, SECRET_KEY_BYTES);
    crypto_kem_enc(ct, key, pk);

    start = get_systick();
    crypto_kem_dec(key, ct, sk);
    end = get_systick();
}

/**
 * @brief Same function as crypto_kem_enc, but replaces m with m_const
*/
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