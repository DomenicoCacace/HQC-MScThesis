#ifndef FIPS202_MASKED_H
#define FIPS202_MASKED_H

#include <stddef.h>
#include <stdint.h>

#include "fips202.h"
#include "shares.h"

typedef struct {
    uint64_t ctx0[26];
    uint64_t ctx1[26];
} shake256incctx_masked;

void shake256_init_masked(shake256incctx_masked *state);

void shake256_absorb_masked(shake256incctx_masked *state, const uint8_t *input1, const uint8_t *input2, size_t inlen);

void shake256_squeeze_masked(uint8_t *output1, uint8_t *output2, size_t outlen, shake256incctx_masked *state);

void shake256_masked(uint8_t *output1, uint8_t *output2, size_t outlen, const uint8_t *input1, const uint8_t *input2, size_t inlen);

#endif
