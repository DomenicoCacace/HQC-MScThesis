/**
 * @file mask.c
 * @brief Functional tests for multiplication, PKE and KEM functions
 */

#include "architecture_detect.h"

#if MODE == POWER

#include <string.h> // memcmp

#include "api.h"
#include "board_utils.h"
#include "code.h"
#include "gf2x.h"
#include "hqc.h"
#include "main.h"
#include "parsing.h"
#include "shake_ds.h"
#include "shares.h"
#include "vector.h"


void encrypt(DIGIT *u, DIGIT *v, DIGIT *m, unsigned char *theta, const unsigned char *pk);

void decrypt(DIGIT *m, const DIGIT *u, const DIGIT *v, const unsigned char *sk);

void recv_key(unsigned char *pk, unsigned char *sk);

void recv_ptx(DIGIT *m);

void recv_ctx(DIGIT *u, DIGIT *v);

void wait_connection();

int run(int reps) {
    unsigned char pk[PUBLIC_KEY_BYTES] = {0};
    unsigned char sk[SECRET_KEY_BYTES] = {0};
    DIGIT u[VEC_N_SIZE_DIGIT] = {0};
    DIGIT v[VEC_N1N2_SIZE_DIGIT] = {0};
    DIGIT m[VEC_K_SIZE_DIGIT] = {0};
    uint8_t theta[SHAKE256_512_BYTES] = {0};

    wait_connection();
    
    recv_key(pk, sk);

    #ifdef ENCRYPT
    for(int i = 0; i < reps; i++) {
        recv_ptx(m);
        randombytes(theta, SHAKE256_512_BYTES);

        DELAY(20000);   // 250 us
        TRIGGER_SET

        encrypt(u, v, m, theta, pk);

        TRIGGER_RESET
        DELAY(20000);   // 250 us

        usart_send_str("DONE\n", 5);
    }
    #endif

    #ifdef DECRYPT
        for(int i = 0; i < reps; i++) {
        recv_ctx(u, v);

        DELAY(20000);   // 250 us
        TRIGGER_SET

        decrypt(m, u, v, sk);

        TRIGGER_RESET
        DELAY(20000);   // 250 us

        usart_send_str("DONE\n", 5);
    }
    #endif

    return 0;
}


void encrypt(DIGIT *u, DIGIT *v, DIGIT *m, unsigned char *theta, const unsigned char *pk) {
    seedexpander_state seedexpander;
    DIGIT h[VEC_N_SIZE_DIGIT] = {0};
    DIGIT s[VEC_N_SIZE_DIGIT] = {0};
    DIGIT e[VEC_N_SIZE_DIGIT] = {0};
    shares_n_t r1;
    shares_n_t r2;
    shares_n_t tmp1;
    shares_n_t tmp2;
    shares_n1n2_t _v;
    shares_k_t _m;

    shares_n_init(&r1);
    shares_n_init(&r2);
    shares_n1n2_init(&_v);
    shares_k_init(&_m);
    shares_n_init(&tmp1);
    shares_n_init(&tmp2);

    // Create seed_expander from theta
    seedexpander_init(&seedexpander, theta, SEED_BYTES);

    // Retrieve h and s from public key
    hqc_public_key_from_string(h, s, pk);

    // Generate r1, r2 and e
    vect_set_random_fixed_weight(&seedexpander, r1.s0, PARAM_OMEGA_R);
    vect_set_random_fixed_weight(&seedexpander, r2.s0, PARAM_OMEGA_R);
    vect_set_random_fixed_weight(&seedexpander, e, PARAM_OMEGA_E);
    shares_init_from_data(&r1, r1.s0);
    shares_init_from_data(&r2, r2.s0);

    // Compute u = r1 + r2.h
    shares_vec_mul(&tmp1, &r2, h);
    shares_add(&tmp1, &tmp1, &r1);
    shares_collapse_nosum(u, &tmp1);

    // Compute v = m.G by encoding the message
    shares_n_init(&tmp1);
    shares_init_from_msg(&_m, m);
    code_encode_shares(&_v, &_m);
    shares_resize_n(&tmp1, &_v);

    // Compute v = m.G + s.r2 + e
    shares_vec_mul(&tmp2, &r2, s);
    shares_add(&tmp1, &tmp1, &tmp2);
    shares_n_collapse(tmp1.s0, &tmp1, e);
    vect_resize(v, PARAM_N1N2, tmp1.s0, PARAM_N);
}

void decrypt(DIGIT *m, const DIGIT *u, const DIGIT *v, const unsigned char *sk) {
    DIGIT x[VEC_N_SIZE_DIGIT] = {0};
    DIGIT y[VEC_N_SIZE_DIGIT] = {0};
    uint8_t pk[PUBLIC_KEY_BYTES] = {0};
    DIGIT tmp1[VEC_N_SIZE_DIGIT] = {0};
    DIGIT tmp2[VEC_N_SIZE_DIGIT] = {0};

    // Retrieve x, y, pk from secret key
    hqc_secret_key_from_string(x, y, pk, sk);

    // Compute v - u.y
    vect_resize(tmp1, PARAM_N, v, PARAM_N1N2);
    opt_mul(tmp2, y, u);
    vect_add(tmp2, tmp1, tmp2, VEC_N_SIZE_DIGIT);
    code_decode(m, tmp2);
}

void recv_key(unsigned char *pk, unsigned char *sk) {
    uint8_t *p;
    p = (uint8_t *)pk;
    usart_recv_str(p, PUBLIC_KEY_BYTES);
    p = (uint8_t *)sk;
    usart_recv_str(p, SECRET_KEY_BYTES);
}

void recv_ptx(DIGIT *m) {
    uint8_t *p = (uint8_t *)m;
    usart_recv_str(p, VEC_K_SIZE_BYTES);
}

void recv_ctx(DIGIT *u, DIGIT *v) {
    uint8_t *p; 
    p = (uint8_t *)u;
    usart_recv_str(p, VEC_N_SIZE_BYTES);

    p = (uint8_t *)v;
    usart_recv_str(p, VEC_N1N2_SIZE_BYTES);

}

void wait_connection() {
    char str[4] = {0};
    usart_recv_str(str, 4);
    usart_send_str("OK\n", 3);
    DELAY(1000);
}

#endif
