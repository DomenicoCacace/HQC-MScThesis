/**
 * @file shares.h
 * @brief Definitions of share types and relative operations
 */

#pragma once

#include <stdint.h>
#include <string.h>
#include "gf2x.h"
#include "../common/parameters.h"
#include "../common/vector.h"


// TODO: allow the choice of this parameter via CMake/PlatformIO 
#define SHARES (2)
#define RANDOM_BYTES shake_prng // to be changed when testing with a TRNG


#if SHARES == 1
    typedef struct shares_n_t {
        uint32_t s0[VEC_N_SIZE_32];
    } shares_n_t;
#elif SHARES == 2
    typedef struct shares_n_t {
        uint32_t s0[VEC_N_SIZE_32];
        uint32_t s1[VEC_N_SIZE_32];
    } shares_n_t;

    typedef struct shares_k_t {
        uint32_t s0[VEC_K_SIZE_32];
        uint32_t s1[VEC_K_SIZE_32];
    } shares_k_t;

    typedef struct shares_n1n2_t {
        uint32_t s0[VEC_N1N2_SIZE_32];
        uint32_t s1[VEC_N1N2_SIZE_32];
    } shares_n1n2_t;
#else
#error TOO_MANY_SHARES
#endif

static inline
void shares_n_init(shares_n_t *o) {
    memset(o, 0, VEC_N_SIZE_BYTES * SHARES);
}

static inline
void shares_k_init(shares_k_t *o) {
    memset(o, 0, VEC_K_SIZE_BYTES * SHARES);
}

static inline
void shares_n1n2_init(shares_n1n2_t *o) {
    memset(o, 0, VEC_N1N2_SIZE_BYTES * SHARES);
}

static inline
void shares_init_from_data(shares_n_t *o, const uint32_t *data) {
    uint32_t mask[VEC_N_SIZE_32];
    RANDOM_BYTES((uint8_t *)mask, VEC_N_SIZE_BYTES);

#if SHARES == 1
    for(int i = 0; i < VEC_N_SIZE_32; i++)
        o->s0[i] = data[i];
#elif SHARES == 2
    for(int i = 0; i < VEC_N_SIZE_32; i++) {
        o->s0[i] = data[i] ^ mask[i];
        o->s1[i] = mask[i];
    }
#endif
}

static inline
void shares_init_from_msg(shares_k_t *o, const uint32_t *msg) {
        uint32_t mask[VEC_K_SIZE_32];
    RANDOM_BYTES((uint8_t *)mask, VEC_K_SIZE_BYTES);

#if SHARES == 1
    for(int i = 0; i < VEC_K_SIZE_32; i++)
        o->s0[i] = msg[i];
#elif SHARES == 2
    for(int i = 0; i < VEC_K_SIZE_32; i++) {
        o->s0[i] = msg[i] ^ mask[i];
        o->s1[i] = mask[i];
    }
#endif
}

static inline
void shares_init_random(shares_n_t *o) {
#if SHARES == 1
    RANDOM_BYTES((uint8_t *)o->s0, VEC_N_SIZE_BYTES);
#elif SHARES == 2
    RANDOM_BYTES((uint8_t *)o->s0, VEC_N_SIZE_BYTES);
    RANDOM_BYTES((uint8_t *)o->s1, VEC_N_SIZE_BYTES);
#endif
}

static inline
void shares_init_random_msg(shares_k_t *o) {
#if SHARES == 1
    RANDOM_BYTES((uint8_t *)o->s0, VEC_N_SIZE_BYTES);
#elif SHARES == 2
    RANDOM_BYTES((uint8_t *)o->s0, VEC_K_SIZE_BYTES);
    RANDOM_BYTES((uint8_t *)o->s1, VEC_K_SIZE_BYTES);
#endif
}

static inline
void shares_add(shares_n_t *o, shares_n_t *a, shares_n_t *b) {
    uint32_t mask[VEC_N_SIZE_32];
    RANDOM_BYTES((uint8_t *)mask, VEC_N_SIZE_BYTES);
#if SHARES == 1
    for(int i = 0; i < VEC_N_SIZE_32; i++)
        o->s0[i] = a->s0[i] ^ b->s0[i];
#elif SHARES == 2
    for(int i = 0; i < VEC_N_SIZE_32; i++) {
        o->s0[i] = a->s0[i] ^ (b->s0[i] ^ mask[i]);
        o->s1[i] = (a->s1[i] ^ mask[i]) ^ b->s1[i];
    }
#endif
}

static inline
void shares_vec_mul(shares_n_t *o, shares_n_t *a, const uint32_t *b) {
#if SHARES == 1
    opt_mul(o->s0, a->s0, b);
#elif SHARES == 2
    opt_mul(o->s0, a->s0, b);
    opt_mul(o->s1, a->s1, b);
#endif
}

static inline 
void shares_n_collapse(uint32_t *o, shares_n_t *shares, uint32_t *v) {
#if SHARES == 1
    for(int i = 0; i < VEC_N_SIZE_32; i++)
        o[i] = v[i] ^ shares->s0[i];
#elif SHARES == 2
    for(int i = 0; i < VEC_N_SIZE_32; i++)
        o[i] = v[i] ^ shares->s0[i];
    for(int i = 0; i < VEC_N_SIZE_32; i++)
        o[i] = o[i] ^ shares->s1[i];
#endif
}

static inline 
void shares_collapse_msg(uint32_t *o, shares_k_t *shares, uint32_t *v) {
#if SHARES == 1
    for(int i = 0; i < VEC_N_SIZE_32; i++)
        o[i] = v[i] ^ shares->s0[i];
#elif SHARES == 2
    for(int i = 0; i < VEC_K_SIZE_32; i++)
        o[i] = v[i] ^ shares->s0[i];
    for(int i = 0; i < VEC_K_SIZE_32; i++)
        o[i] = o[i] ^ shares->s1[i];
#endif
}

static inline 
void shares_collapse_nosum(uint32_t *o, shares_n_t *shares) {
#if SHARES == 1
    for(int i = 0; i < VEC_N_SIZE_32; i++)
        o[i] = shares->s0[i];
#elif SHARES == 2
    for(int i = 0; i < VEC_N_SIZE_32; i++)
        o[i] = shares->s0[i] ^ shares->s1[i];
#endif
}

static inline
void shares_resize_n(shares_n_t *o, shares_n1n2_t *v) {
#if SHARES == 1
    vect_resize(o->s0, size_o, v->s0, size_v);
#elif SHARES == 2
    vect_resize(o->s0, PARAM_N, v->s0, PARAM_N1N2);
    vect_resize(o->s1, PARAM_N, v->s1, PARAM_N1N2);
#endif
}

static inline
void shares_resize_n1n2(shares_n1n2_t *o, shares_n_t *v) {
#if SHARES == 1
    vect_resize(o->s0, size_o, v->s0, size_v);
#elif SHARES == 2
    vect_resize(o->s0, PARAM_N1N2, v->s0, PARAM_N);
    vect_resize(o->s1, PARAM_N1N2, v->s1, PARAM_N);
#endif
}
