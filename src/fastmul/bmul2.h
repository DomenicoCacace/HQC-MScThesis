// Implemented by Ming-Shing Chen, Tung Chou and Markus Krausz.
// public domain
#ifndef _BMUL_2_H_
#define _BMUL_2_H_

#include "stdint.h"

// ffft based mulitplication for bit-polynomials
// Use Froebinus FFT

// input transform for the multiplication.
void bmul2_prepare(uint32_t *a_out, const uint8_t *a_in);

// multiplication with input operands after input transform.
void bmul2_mul(uint8_t *c, const uint32_t *a, const uint32_t *b);

// multiplication for bit polynomials
void bmul2(uint8_t *c, const uint8_t *a, const uint8_t *b);


#endif
