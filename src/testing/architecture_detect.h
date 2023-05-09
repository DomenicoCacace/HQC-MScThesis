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
#define TTEST_FAST 4
#define TIMING_FAST 5
#define POWER 6

#define CAT(a, b) a ## b
#define CONST(a) CAT(a, _CONST)

#define DELAY(x) for(int _i = 0; _i < x/4; _i++) {asm volatile("nop;");}
#define RNG_DELAY DELAY(42*8)

#include <stdint.h>

/**
 * @brief Fills a vector with random bytes
 * @param[out] x The vector to fill
 * @param[in] xlen The length of the vector in bytes
 */
static int randombytes(uint8_t *obuf, uint16_t xlen);

#ifdef CORTEX_M4
#include "board_utils.h"
#include "shake_prng.h"

#define PRINTF(...) debug(__VA_ARGS__)

#define TRIGGER_SET trigger_set();
#define TRIGGER_RESET trigger_reset();

static int randombytes(uint8_t *obuf, uint16_t len) {
    union {
        unsigned char aschar[4];
        uint32_t asint;
    } random;

    while (len > 4) {
        RNG_DELAY
        random.asint = rng_get_random_blocking();
        *obuf++ = random.aschar[0];
        *obuf++ = random.aschar[1];
        *obuf++ = random.aschar[2];
        *obuf++ = random.aschar[3];
        len -= 4;
    }
    if (len > 0) {
        RNG_DELAY
        for (random.asint = rng_get_random_blocking(); len > 0; --len) {
            *obuf++ = random.aschar[len - 1];
        }
    }
    return 0;
}

#else
#include <stdio.h>
#include "shake_prng.h"

#define PRINTF(...) printf(__VA_ARGS__)

#define TRIGGER_SET
#define TRIGGER_RESET

static int randombytes(uint8_t *obuf, uint16_t xlen) {
    shake_prng(obuf, xlen);
    return 0;
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
