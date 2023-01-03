// Implemented by Ming-Shing Chen, Tung Chou and Markus Krausz.
// public domain

#ifndef GFV_TOWER_ASM_H_
#define GFV_TOWER_ASM_H_

#include <stdint.h>

void gf4v_mul_2_asm(uint32_t *c, const uint32_t *a);

void gf4v_mul_asm(uint32_t *c, const uint32_t *a, const uint32_t *b);

void gf4v_mulscalar_asm(uint32_t *c, const uint32_t *a, uint8_t b);

void gf16v_mul_asm(uint32_t *c, const uint32_t *a, const uint32_t *b);

void gf16v_mulscalar_asm(uint32_t *c, const uint32_t *a, uint8_t b);

void gf16v_mul_0x4_asm(uint32_t *c, const uint32_t *a);

void gf16v_mul_0x5_asm(uint32_t *c, const uint32_t *a);

void gf16v_mul_8_asm(uint32_t *c, const uint32_t *a);

void gf256v_mul_asm(uint32_t *c, const uint32_t *a, const uint32_t *b);

void gf256v_mulscalar_asm(uint32_t *c, const uint32_t *a, uint8_t b);

void gf256v_mul_0x80_asm(uint32_t *c, const uint32_t *a);

void gf216v_mul_asm(uint32_t *c, const uint32_t *a, const uint32_t *b);

void gf216v_mul_0x8000_asm(uint32_t *c, const uint32_t *a);

void gf232v_mul_asm(uint32_t *c, const uint32_t *a, const uint32_t *b);

void gf232v_mul_0x2_asm(uint32_t *c, const uint32_t *a);

void gf232v_mul_0x5_asm(uint32_t *c, const uint32_t *a);

void gf232v_mul_gf16_asm(uint32_t *c, const uint32_t *a, const uint32_t *b_gf16);

void gf232v_mul_gf256_asm(uint32_t *c, const uint32_t *a, const uint32_t *b_gf256);

void gf232v_mul_gf216_asm(uint32_t *c, const uint32_t *a, const uint32_t *b_gf216);

void gf232v_mulscalar_gf16_asm(uint32_t *c, const uint32_t *a, uint8_t b);

void gf232v_mulscalar_gf256_asm(uint32_t *c, const uint32_t *a, uint8_t b);

void gf232v_mulscalar_asm(uint32_t *c, const uint32_t *a, uint32_t _b);

#endif
