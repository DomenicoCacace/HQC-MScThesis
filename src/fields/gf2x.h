#ifndef GF2X_H
#define GF2X_H

/**
 * @file gf2x.h
 * @brief Header file for gf2x.c
 */

#include "parameters.h"
#include "shake_prng.h"

void vect_mul(DIGIT *o, const uint32_t *v1, const DIGIT *v2, uint16_t weight, seedexpander_state *ctx);

#endif
