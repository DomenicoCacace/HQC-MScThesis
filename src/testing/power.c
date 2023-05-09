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
#include "vector.h"


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

        hqc_pke_encrypt(u, v, m, theta, pk);

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

        hqc_pke_decrypt(m, u, v, sk);

        TRIGGER_RESET
        DELAY(DELAY_AMT);   // 250 us


        #ifdef DEBUG
        send_ptx(m);
        #endif

        usart_send_str("DONE\n", 5);
    }
    #endif

    return 0;
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
