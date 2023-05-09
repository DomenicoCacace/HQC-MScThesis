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


void encrypt_nomask(DIGIT *u, DIGIT *v, DIGIT *m, unsigned char *theta, const unsigned char *pk);

void decrypt_nomask(DIGIT *m, const DIGIT *u, const DIGIT *v, const unsigned char *sk);


void recv_key(unsigned char *pk, unsigned char *sk);

void recv_ptx(DIGIT *m);

void recv_encoded(DIGIT *c);

void recv_ctx(DIGIT *u, DIGIT *v);

void send_ptx(DIGIT *m);

void send_ctx(DIGIT *u, DIGIT *v);

void wait_connection();

#define DELAY_AMT (20000*100)
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
    while(1) {
        recv_ptx(m);
        randombytes(theta, SHAKE256_512_BYTES);

        DELAY(DELAY_AMT);   // 250 us
        TRIGGER_SET
        #ifdef MASK_ENABLE
        hqc_pke_encrypt(u, v, m, theta, pk);
        #else
        encrypt_nomask(u, v, m, theta, pk);
        #endif

        TRIGGER_RESET
        DELAY(DELAY_AMT);   // 250 us

        #ifdef DEBUG
        send_ctx(u, v);
        #endif

        usart_send_str("DONE\n", 5);
    }
    #endif

    #ifdef DECRYPT
    while(1) {
        recv_ctx(u, v);

        DELAY(DELAY_AMT);   // 250 us
        TRIGGER_SET
        
        #ifdef MASK_ENABLE
        hqc_pke_decrypt(m, u, v, sk);
        #else
        decrypt_nomask(m, u, v, sk);
        #endif

        TRIGGER_RESET
        DELAY(DELAY_AMT);   // 250 us


        #ifdef DEBUG
        send_ptx(m);
        #endif

        usart_send_str("DONE\n", 5);
    }
    #endif

    #ifdef DECODE
    DIGIT c[VEC_N1N2_SIZE_DIGIT] = {0};
    DIGIT m_mask[VEC_K_SIZE_DIGIT] = {0};
    DIGIT c_mask[VEC_N1N2_SIZE_DIGIT] = {0};
    while(1) {
        recv_encoded(c);
        RANDOM_BYTES(m_mask, VEC_K_SIZE_BYTES);
        code_encode(c_mask, m_mask);
        vect_add(c, c, c_mask, VEC_N1N2_SIZE_DIGIT);

        DELAY(DELAY_AMT);   // 250 us
        TRIGGER_SET

        code_decode(m, c);

        TRIGGER_RESET
        DELAY(DELAY_AMT);   // 250 us

        vect_add(m, m, m_mask, VEC_K_SIZE_DIGIT);

        #ifdef DEBUG
        send_ptx(m);
        #endif

        usart_send_str("DONE\n", 5);
    }
    #endif

    #ifdef RSDECODE
    DIGIT c[VEC_N1N2_SIZE_DIGIT] = {0};
    DIGIT m_mask[VEC_K_SIZE_DIGIT] = {0};
    DIGIT c_mask[VEC_N1N2_SIZE_DIGIT] = {0};
    DIGIT tmp[VEC_N1_SIZE_DIGIT] = {0};
    while(1) {
        recv_encoded(c);
        RANDOM_BYTES(m_mask, VEC_K_SIZE_BYTES);
        code_encode(c_mask, m_mask);
        vect_add(c, c, c_mask, VEC_N1N2_SIZE_DIGIT);

        reed_muller_decode(tmp, c);

        DELAY(DELAY_AMT);   // 250 us
        TRIGGER_SET

        reed_solomon_decode(m, tmp);

        TRIGGER_RESET
        DELAY(DELAY_AMT);   // 250 us

        vect_add(m, m, m_mask, VEC_K_SIZE_DIGIT);

        #ifdef DEBUG
        send_ptx(m);
        #endif

        usart_send_str("DONE\n", 5);
    }
    #endif


    return 0;
}

void encrypt_nomask(DIGIT *u, DIGIT *v, DIGIT *m, unsigned char *theta, const unsigned char *pk) {
    seedexpander_state seedexpander;
    DIGIT h[VEC_N_SIZE_DIGIT] = {0};
    DIGIT s[VEC_N_SIZE_DIGIT] = {0};
    DIGIT r1[VEC_N_SIZE_DIGIT] = {0};
    DIGIT r2[VEC_N_SIZE_DIGIT] = {0};
    DIGIT e[VEC_N_SIZE_DIGIT] = {0};
    DIGIT tmp1[VEC_N_SIZE_DIGIT] = {0};
    DIGIT tmp2[VEC_N_SIZE_DIGIT] = {0};

    // Create seed_expander from theta
    seedexpander_init(&seedexpander, theta, SEED_BYTES);

    // Retrieve h and s from public key
    hqc_public_key_from_string(h, s, pk);

    // Generate r1, r2 and e
    vect_set_random_fixed_weight(&seedexpander, e, PARAM_OMEGA_E);
    vect_set_random_fixed_weight(&seedexpander, r1, PARAM_OMEGA_R);
    vect_set_random_fixed_weight(&seedexpander, r2, PARAM_OMEGA_R);

    // Compute u = r1 + r2.h
    opt_mul(u, r2, h);
    vect_add(u, r1, u, VEC_N_SIZE_DIGIT);

    // Compute v = m.G by encoding the message
    code_encode(v, m);
    vect_resize(tmp1, PARAM_N, v, PARAM_N1N2);

    // Compute v = m.G + s.r2 + e
    opt_mul(tmp2, r2, s);
    vect_add(tmp2, e, tmp2, VEC_N_SIZE_DIGIT);
    vect_add(tmp2, tmp1, tmp2, VEC_N_SIZE_DIGIT);
    vect_resize(v, PARAM_N1N2, tmp2, PARAM_N);
}

void decrypt_nomask(DIGIT *m, const DIGIT *u, const DIGIT *v, const unsigned char *sk) {
    DIGIT x[VEC_N_SIZE_DIGIT] = {0};
    DIGIT y[VEC_N_SIZE_DIGIT] = {0};
    uint8_t pk[PUBLIC_KEY_BYTES] = {0};
    DIGIT tmp1[VEC_N_SIZE_DIGIT] = {0};
    DIGIT tmp2[VEC_N_SIZE_DIGIT] = {0};
    seedexpander_state perm_seedexpander;
    uint8_t perm_seed[SEED_BYTES] = {0};

    // Retrieve x, y, pk from secret key
    hqc_secret_key_from_string(x, y, pk, sk);

    randombytes(perm_seed, SEED_BYTES);
    seedexpander_init(&perm_seedexpander, perm_seed, SEED_BYTES);

    // Compute v - u.y
    vect_resize(tmp1, PARAM_N, v, PARAM_N1N2);
    opt_mul(tmp2, y, u);
    vect_add(tmp2, tmp1, tmp2, VEC_N_SIZE_DIGIT);

    // Compute m by decoding v - u.y
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

void recv_encoded(DIGIT *c) {
    uint8_t *p = (uint8_t *)c;
    usart_recv_str(p, VEC_N1N2_SIZE_BYTES);
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
