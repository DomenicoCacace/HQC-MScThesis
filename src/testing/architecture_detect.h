#ifndef ARCHITECTURE_DETECT_H
#define ARCHITECTURE_DETECT_H

/**
 * @file architecture_detect.h
 * @brief Utilities to detect the architecture and select the correct implementation
 */

#define FUNCTIONAL 0
#define TIMING 1
#define PLAIN 2
#define TTEST 3

#define CAT(a, b) a ## b
#define CONST(a) CAT(a, _CONST)

#define DELAY(x) for(int _i = 0; _i < x/4; _i++) {asm volatile("nop;");}

#include <stdint.h>

/**
 * @brief Fills a vector with random bytes
 * @param[out] x The vector to fill
 * @param[in] xlen The length of the vector in bytes
 */
static void randombytes(uint8_t *x, uint16_t xlen);

#ifdef CORTEX_M4
#include "board_utils.h"
#include "shake_prng.h"

#define PRINTF(...) debug(__VA_ARGS__)

#define TRIGGER_SET trigger_set();
#define TRIGGER_RESET trigger_reset();

static void randombytes(uint8_t *x, uint16_t xlen) {
    uint8_t rand[4];
    for (int i = 0; i < (xlen/4)*4; i+=4) {
        rng_get_random((uint32_t *)rand);
        x[i] = *rand;
    }
    rng_get_random((uint32_t *)rand);
    for (int i = (xlen/4)*4; i < xlen; i++) {
        x[i] = rand[i-(xlen/4)*4];
    }
}

#else
#include <stdio.h>
#include "shake_prng.h"

#define PRINTF(...) printf(__VA_ARGS__)

#define TRIGGER_SET
#define TRIGGER_RESET

static void randombytes(uint8_t *x, uint16_t xlen) {
    shake_prng(x, xlen);
}


#if defined(__MMX__)    && defined(__SSE__)       && defined(__SSE_MATH__) && \
    defined(__SSE2__)   && defined(__SSE2_MATH__) && defined(__SSE3__)     && \
    defined(__SSE4_1__) && defined(__SSE4_2__)    && defined(__POPCNT__)   && \
    defined(__PCLMUL__) && defined(__AES__)       && defined(__AVX__)      && \
    defined(__amd64__)

#define HIGH_COMPATIBILITY_X86_64

#include <x86intrin.h>
#include <wmmintrin.h>
#include <immintrin.h>
#include <stdalign.h>

#endif

#if defined(HIGH_COMPATIBILITY_X86_64)            && \
    defined(__BMI__)  && defined(__BMI2__) && \
    defined(__AVX2__) && defined(__LZCNT__)

#define HIGH_PERFORMANCE_X86_64
#include <pmmintrin.h>

#endif

#endif

#endif
