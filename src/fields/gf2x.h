#ifndef GF2X_H
#define GF2X_H

/**
 * @file gf2x.h
 * @brief Header file for gf2x.c
 */

#include "parameters.h"
#include "shake_prng.h"

#define VEC_N_SIZE_64 CEIL_DIVIDE(PARAM_N, 64)

void vect_mul(uint64_t *o, const uint32_t *v1, const uint64_t *v2, uint16_t weight, seedexpander_state *ctx);

void vect_mul_noshuffle(uint64_t *o, const uint32_t *v1, const uint64_t *v2, uint16_t weight);

#endif
