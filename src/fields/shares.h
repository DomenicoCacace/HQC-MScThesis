/**
 * @file shares.h
 * @brief Definitions of share types and relative operations
 */


#include <stdint.h>
#include <string.h>
#include "gf2x.h"
#include "../common/parameters.h"
#include "../common/vector.h"


// TODO: allow the choice of this parameter via CMake/PlatformIO 
#define SHARES (2)
#define RANDOM_BYTES shake_prng // to be changed when testing with a TRNG


#if SHARES == 1
    typedef struct dense_shares_t {
        uint64_t s0[VEC_N_SIZE_64];
    } dense_shares_t;

    typedef struct sparse_shares_t {
        uint32_t s0[PARAM_OMEGA];
    } sparse_shares_t;

    typedef struct sparse_r_shares_t {
        uint32_t s0[PARAM_OMEGA_R];
    } sparse_r_shares_t;
#elif SHARES == 2
    typedef struct dense_shares_t {
        uint64_t s0[VEC_N_SIZE_64];
        uint64_t s1[VEC_N_SIZE_64];
    } dense_shares_t;

    typedef struct sparse_shares_t {
        uint32_t s0[PARAM_OMEGA];
        uint32_t s1[PARAM_OMEGA];
    } sparse_shares_t;

    typedef struct sparse_r_shares_t {
        uint32_t s0[PARAM_OMEGA_R];
        uint32_t s1[PARAM_OMEGA_R];
    } sparse_r_shares_t;
#else
#error TOO_MANY_SHARES
#endif

static inline
void dense_shares_init_from_data(sparse_shares_t *o, const uint64_t *data) {
    uint64_t mask[VEC_N_SIZE_64];
    RANDOM_BYTES((uint8_t *)mask, VEC_N_SIZE_BYTES);

#if SHARES == 1
    for(int i = 0; i < VEC_N_SIZE_64; i++)
        o->s0[i] = data[i];
#elif SHARES == 2
    for(int i = 0; i < VEC_N_SIZE_64; i++) {
        o->s0[i] = data[i] ^ mask[i];
        o->s1[i] = mask[i];
    }
#endif
}

static inline
void dense_shares_init_random(dense_shares_t *o) {
#if SHARES == 1
    RANDOM_BYTES((uint8_t *)o->s0, VEC_N_SIZE_BYTES);
#elif SHARES == 2
    RANDOM_BYTES((uint8_t *)o->s0, VEC_N_SIZE_BYTES);
    RANDOM_BYTES((uint8_t *)o->s1, VEC_N_SIZE_BYTES);
#endif
}

static inline
void sparse_shares_init_from_data(sparse_shares_t *o, const uint32_t *data) {
    uint8_t seed[SEED_BYTES] = {0};
    seedexpander_state seedexpander;
    RANDOM_BYTES(seed, SEED_BYTES);
    seedexpander_init(&seedexpander, seed, SEED_BYTES);

#if SHARES == 1
    for(int i = 0; i < PARAM_OMEGA; i++)
        o->s0[i] = data[i];
#elif SHARES == 2
    memcpy(o->s0, data, PARAM_OMEGA * sizeof(uint32_t));
    vect_set_random_fixed_weight_by_coordinates(&seedexpander, o->s1, PARAM_OMEGA);
    // TODO: swap randomly positions of mask and data
#endif
}

static inline
void sparse_shares_init_random(sparse_shares_t *o) {
    uint8_t seed[SEED_BYTES] = {0};
    seedexpander_state seedexpander;
    RANDOM_BYTES(seed, SEED_BYTES);
    seedexpander_init(&seedexpander, seed, SEED_BYTES);

#if SHARES == 1
    vect_set_random_fixed_weight_by_coordinates(&seedexpander, o->s0, PARAM_OMEGA);
#elif SHARES == 2
    vect_set_random_fixed_weight_by_coordinates(&seedexpander, o->s0, PARAM_OMEGA);
    vect_set_random_fixed_weight_by_coordinates(&seedexpander, o->s1, PARAM_OMEGA);
    // TODO: swap randomly positions of mask and data
#endif
}

static inline
void sparse_r_shares_init_random(sparse_r_shares_t *o) {
    uint8_t seed[SEED_BYTES] = {0};
    seedexpander_state seedexpander;
    RANDOM_BYTES(seed, SEED_BYTES);
    seedexpander_init(&seedexpander, seed, SEED_BYTES);

#if SHARES == 1
    vect_set_random_fixed_weight_by_coordinates(&seedexpander, o->s0, PARAM_OMEGA_R);
#elif SHARES == 2
    vect_set_random_fixed_weight_by_coordinates(&seedexpander, o->s0, PARAM_OMEGA_R);
    vect_set_random_fixed_weight_by_coordinates(&seedexpander, o->s1, PARAM_OMEGA_R);
    // TODO: swap randomly positions of mask and data
#endif
}


static inline
void dense_shares_add(dense_shares_t *o, dense_shares_t *a, dense_shares_t *b) {
    uint64_t mask[VEC_N_SIZE_64];
    RANDOM_BYTES((uint8_t *)mask, VEC_N_SIZE_BYTES);
#if SHARES == 1
    for(int i = 0; i < VEC_N_SIZE_64; i++)
        o->s0[i] = a->s0[i] ^ b->s0[i];
#elif SHARES == 2
    for(int i = 0; i < VEC_N_SIZE_64; i++) {
        o->s0[i] = a->s0[i] ^ (b->s0[i] ^ mask[i]);
        o->s1[i] = (a->s1[i] ^ mask[i]) ^ b->s1[i];
    }
#endif
}

static inline
void dense_sparse_shares_mul(dense_shares_t *o, sparse_shares_t *a, uint64_t *b) {
    uint8_t seed[SEED_BYTES] = {0};
    seedexpander_state ctx;
    RANDOM_BYTES(seed, SEED_BYTES);
    seedexpander_init(&ctx, seed, SEED_BYTES);

#if SHARES == 1
    vect_mul(o->s0, a-, b->s0, PARAM_OMEGA, ctx);
#elif SHARES == 2
    vect_mul(o->s0, a->s0, b, PARAM_OMEGA, &ctx);
    vect_mul(o->s1, a->s1, b, PARAM_OMEGA, &ctx);
#endif
}

static inline
void dense_sparse_r_shares_mul(dense_shares_t *o, sparse_r_shares_t *a, uint64_t *b) {
    uint8_t seed[SEED_BYTES] = {0};
    seedexpander_state ctx;
    RANDOM_BYTES(seed, SEED_BYTES);
    seedexpander_init(&ctx, seed, SEED_BYTES);

#if SHARES == 1
    vect_mul(o->s0, a-, b->s0, PARAM_OMEGA, ctx);
#elif SHARES == 2
    vect_mul(o->s0, a->s0, b, PARAM_OMEGA_R, &ctx);
    vect_mul(o->s1, a->s1, b, PARAM_OMEGA_R, &ctx);
#endif
}

static inline 
void dense_shares_collapse(uint64_t *o, dense_shares_t *shares, uint64_t *v) {
#if SHARES == 1
    for(int i = 0; i < VEC_N_SIZE_64; i++)
        o[i] = v[i] ^ shares->s0[i];
#elif SHARES == 2
    for(int i = 0; i < VEC_N_SIZE_64; i++)
        o[i] = v[i] ^ shares->s0[i];
    for(int i = 0; i < VEC_N_SIZE_64; i++)
        o[i] = o[i] ^ shares->s1[i];
#endif
}