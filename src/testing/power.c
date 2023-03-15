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

void send_ptx(DIGIT *m);

void send_ctx(DIGIT *u, DIGIT *v);

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

        #ifdef DEBUG
        send_ctx(u, v);
        #endif

        usart_send_str("DONE\n", 5);
    }
    #endif

    #ifdef DECRYPT
        for(int i = 0; i < reps; i++) {
        recv_ctx(u, v);

        DELAY(20000);   // 250 us
        TRIGGER_SET

        decrypt(m, u, v, sk);

        #ifdef DEBUG
        send_ptx(m);
        #endif

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
    uint8_t pk[PUBLIC_KEY_BYTES] = {0};
    shares_n_t y;
    DIGIT _v[VEC_N_SIZE_DIGIT] = {0};
    shares_k_t _m;
    shares_n1n2_t c;
    shares_n_t tmp1;

    // Retrieve x, y, pk from secret key
    shares_n_init(&y);
    hqc_secret_key_from_string(x, y.s0, pk, sk);
    shares_init_from_data(&y, y.s0);

    // Generate and encode a random codeword
    shares_init_random_msg(&_m);
    shares_n1n2_init(&c);
    code_encode_shares(&c, &_m);

    // Mask v with the encoded random codeword
    shares_n_init(&tmp1);
    vect_resize(_v, PARAM_N, v, PARAM_N1N2);
    shares_resize_n(&tmp1, &c);
    shares_n_collapse(_v, &tmp1, _v);

    // Compute u.y
    shares_n_init(&tmp1);
    shares_vec_mul(&tmp1, &y, u);

    // Compute v - u.y
    shares_n_collapse(_v, &tmp1, _v);

    // Decode v - u.y
    //shares_n_init(&tmp1);
    code_decode(m, _v);
    shares_collapse_msg(m, &_m, m);
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

void send_ptx(DIGIT *m) {
    uint8_t *p = (uint8_t *)m;
    char buf[4] = {0};
    for(int i = 0; i < VEC_K_SIZE_BYTES; i++) {
        sprintf(buf, "%02x", p[i]);
        usart_send_str(buf, 2);
    }
    usart_send_str("\n", 1);
}

void send_ctx(DIGIT *u, DIGIT *v) {
    uint8_t *p;
    char buf[4] = {0}; 
    p = (uint8_t *)u;
    for(int i = 0; i < VEC_N_SIZE_BYTES; i++) {
        sprintf(buf, "%02x", p[i]);
        usart_send_str(buf, 2);
    }
    usart_send_str("\n", 1);

    p = (uint8_t *)v;
    for(int i = 0; i < VEC_N1N2_SIZE_BYTES; i++) {
        sprintf(buf, "%02x", p[i]);
        usart_send_str(buf, 2);
    }
    usart_send_str("\n", 1);
}

void wait_connection() {
    char str[4] = {0};
    usart_recv_str(str, 4);
    usart_send_str("OK\n", 3);
    DELAY(1000);
}

#endif
