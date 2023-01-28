#ifndef VECTOR_H
#define VECTOR_H

/**
 * @file vector.h
 * @brief Header file for vector.c
 */

#include "parameters.h"

#include "shake_prng.h"

void vect_set_random_fixed_weight_by_coordinates(seedexpander_state *ctx, uint32_t *v, uint16_t weight);

void vect_set_random_fixed_weight(seedexpander_state *ctx, DIGIT *v, uint16_t weight);

void vect_set_random(seedexpander_state *ctx, DIGIT *v);

void vect_set_random_from_prng(DIGIT *v);

void vect_generate_random_for_mult(DIGIT *v);

void vect_add(DIGIT *o, const DIGIT *v1, const DIGIT *v2, uint32_t size);

uint8_t vect_compare(const uint8_t *v1, const uint8_t *v2, uint32_t size);

void vect_resize(DIGIT *o, uint32_t size_o, const DIGIT *v, uint32_t size_v);

void vect_print(const DIGIT *v, uint32_t size);

void vect_print_sparse(const uint32_t *v, uint16_t weight);

#endif
