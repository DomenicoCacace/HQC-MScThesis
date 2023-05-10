#ifndef SHAKE_DS_H
#define SHAKE_DS_H

/**
 * @file shake_ds.h
 * @brief Header file of shake_ds.c
 */

#include <stdint.h>

#include "domains.h"
#include "fips202.h"
#include "fips202_masked.h"

void shake256_512_ds(shake256incctx *state, uint8_t *output, const uint8_t *input, size_t inlen, uint8_t domain);

void shake256_g(shake256incctx *state, uint8_t *output, const uint8_t *input);

void shake256_h(shake256incctx *state, uint8_t *output, const uint8_t *input);

void shake256_k(shake256incctx *state, uint8_t *output, const uint8_t *input);


#endif
