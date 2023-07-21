#ifndef FIPS202_H
#define FIPS202_H

#include <stddef.h>
#include <stdint.h>

#define SHAKE256_RATE 136

typedef struct {
    uint64_t ctx[26];
} shake256incctx;


void shake256_inc_init(shake256incctx *state);

void shake256_inc_absorb(shake256incctx *state, const uint8_t *input, size_t inlen);

void shake256_inc_finalize(shake256incctx *state);

void shake256_inc_squeeze(uint8_t *output, size_t outlen, shake256incctx *state);

#endif
