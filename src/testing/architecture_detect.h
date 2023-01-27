#ifndef ARCHITECTURE_DETECT_H
#define ARCHITECTURE_DETECT_H

/**
 * @file architecture_detect.h
 * @brief Utilities to detect the architecture and select the correct implementation
 */

#define FUNCTIONAL 0
#define TIMING 1
#define PLAIN 2

#include <stdint.h>

/**
 * @brief Fills a vector with random bytes
 * @param[out] x The vector to fill
 * @param[in] xlen The length of the vector in bytes (must be a multiple of 4)
 */
static void randombytes(uint8_t *x, uint16_t xlen);

#ifdef CORTEX_M4
#include "board_utils.h"

    #define PRINTF(...) debug(__VA_ARGS__)

    #define TRIGGER_SET trigger_set();
    #define TRIGGER_RESET trigger_reset();

    static void randombytes(uint8_t *x, uint16_t xlen) {

        for (int i = 0; i < xlen; i+=4) {
            x[i] = rand();
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

#endif

#endif
