#ifndef GF2X_H
#define GF2X_H

/**
 * @file gf2x.h
 * @brief Header file for gf2x.c
 */

#include <stdint.h>

#include "../common/parameters.h"
#include "../common/vector.h"
#include "../fastmul/bmul2.h"
#include "../lib/shake_prng.h"

void vect_mul(uint64_t *o, const uint32_t *v1, const uint64_t *v2, const uint16_t weight, seedexpander_state *ctx);
void opt_mul(uint32_t *o, const uint32_t *v1, const uint32_t *v2);

#endif
