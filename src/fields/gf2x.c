/**
 * @file gf2x.c
 * @brief Implementation of multiplication of two polynomials
 */

#include <stdint.h>
#include <string.h>

#include "gf2x.h"

/**
 * @brief Compute o(x) = a(x) mod \f$ X^n - 1\f$
 *
 * This function computes the modular reduction of the polynomial a(x)
 *
 * @param[in] a Pointer to the polynomial a(x)
 * @param[out] o Pointer to the result
 */
static void reduce(uint32_t *o, const uint32_t *a) {
    size_t i;
    uint32_t r;
    uint32_t carry;

    for (i = 0; i < VEC_N_SIZE_32; i++) {
        r = a[i + VEC_N_SIZE_32 - 1] >> (PARAM_N & 0x3F);
        carry = (uint32_t ) (a[i + VEC_N_SIZE_32 ] << (32 - (PARAM_N & 0x3F)));
        o[i] = a[i] ^ r ^ carry;
    }
    o[VEC_N_SIZE_32 - 1] &= RED_MASK;
}

/**
 * @brief Multiply two polynomials modulo \f$ X^n - 1\f$.
 *
 * This functions multiplies two dense polynomials modulo \f$ X^n - 1\f$.
 *
 * @param[out] o Pointer to the result
 * @param[in] a1 Pointer to the first polynomial
 * @param[in] a2 Pointer to the second polynomial
 */
void opt_mul(uint32_t *o, const uint32_t *a1, const uint32_t *a2) {
    uint32_t a1_m[32768/32] = {0};
    uint32_t a2_m[32768/32] = {0};
    uint32_t res[32768/32*2] = {0};
    memcpy(a1_m, a1, VEC_N_SIZE_BYTES);
    memcpy(a2_m, a2, VEC_N_SIZE_BYTES);

    bmul2((uint8_t *) res, (const uint8_t *) a1_m, (const uint8_t *) a2_m);
    reduce(o, res);
}



