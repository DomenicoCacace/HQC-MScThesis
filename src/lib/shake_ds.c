/**
 * @file shake_ds.c
 * @brief Implementation SHAKE-256 with incremental API and domain separation
 */

#include "shake_ds.h"

#define XOR(out, in1, in2, len) for(int _i = 0; _i < len; _i++){out[_i] = in1[_i] ^ in2[_i];}

#define INLEN_G (VEC_K_SIZE_BYTES + SEED_BYTES + SALT_SIZE_BYTES)
#define INLEN_H (VEC_K_SIZE_BYTES)
#define INLEN_K (VEC_K_SIZE_BYTES + VEC_N_SIZE_BYTES + VEC_N1N2_SIZE_BYTES)
#define OUTLEN (SHAKE256_512_BYTES)

typedef struct {
    uint8_t p0[INLEN_G+1];
    uint8_t p1[INLEN_G+1];
} g_hash_t;

typedef struct {
    uint8_t p0[INLEN_H+1];
    uint8_t p1[INLEN_H+1];
} h_hash_t;

typedef struct {
    uint8_t p0[INLEN_K+1];
    uint8_t p1[INLEN_K+1];
} k_hash_t;

typedef struct {
    uint8_t p0[OUTLEN];
    uint8_t p1[OUTLEN];
} out_hash_t;


void shake256_g(shake256incctx *state, uint8_t *output, const uint8_t *input) {
#ifdef MASK_ENABLE
    shake256incctx_masked state_masked;
    g_hash_t input_masked;
    out_hash_t output_masked;

    // Init state
    shake256_init_masked(&state_masked);

    // Share-split input
    RANDOM_BYTES(input_masked.p1, INLEN_G);
    XOR(input_masked.p0, input, input_masked.p1, INLEN_G)

    // Set the domain separation byte
    input_masked.p0[INLEN_G] = G_FCT_DOMAIN;
    input_masked.p1[INLEN_G] = 0;

    // Absorb the input + domain separation byte
    shake256_absorb_masked(&state_masked, input_masked.p0, input_masked.p1, INLEN_G+1);

    // Squeeze the output
    shake256_squeeze_masked(output_masked.p0, output_masked.p1, OUTLEN, &state_masked);

    // Merge the shares
    XOR(output, output_masked.p0, output_masked.p1, OUTLEN)
#else
    shake256_512_ds(state, output, input, INLEN_G, G_FCT_DOMAIN);
#endif
}


void shake256_h(shake256incctx *state, uint8_t *output, const uint8_t *input) {
#ifdef MASK_ENABLE
    shake256incctx_masked state_masked;
    h_hash_t input_masked = {0};
    out_hash_t output_masked = {0};

    // Init state
    shake256_init_masked(&state_masked);

    // Share-split input
    RANDOM_BYTES(input_masked.p1, INLEN_H);
    XOR(input_masked.p0, input, input_masked.p1, INLEN_H)

    // Set the domain separation byte
    input_masked.p0[INLEN_H] = H_FCT_DOMAIN;
    input_masked.p1[INLEN_H] = 0;

    // Absorb the input + domain separation byte
    shake256_absorb_masked(&state_masked, input_masked.p0, input_masked.p1, INLEN_H+1);

    // Squeeze the output
    shake256_squeeze_masked(output_masked.p0, output_masked.p1, OUTLEN, &state_masked);

    // Merge the shares
    XOR(output, output_masked.p0, output_masked.p1, OUTLEN)
#else
    shake256_512_ds(state, output, input, INLEN_H, H_FCT_DOMAIN);
#endif
}

void shake256_k(shake256incctx *state, uint8_t *output, const uint8_t *input) {
#ifdef MASK_ENABLE
    shake256incctx_masked state_masked;
    k_hash_t input_masked;
    out_hash_t output_masked;

    // Init state
    shake256_init_masked(&state_masked);

    // Share-split input
    RANDOM_BYTES(input_masked.p1, INLEN_K);
    XOR(input_masked.p0, input, input_masked.p1, INLEN_K)

    // Set the domain separation byte
    input_masked.p0[INLEN_K] = K_FCT_DOMAIN;
    input_masked.p1[INLEN_K] = 0;

    // Absorb the input + domain separation byte
    shake256_absorb_masked(&state_masked, input_masked.p0, input_masked.p1, INLEN_K+1);

    // Squeeze the output
    shake256_squeeze_masked(output_masked.p0, output_masked.p1, OUTLEN, &state_masked);

    // Merge the shares
    XOR(output, output_masked.p0, output_masked.p1, OUTLEN)
#else
    shake256_512_ds(state, output, input, INLEN_G, K_FCT_DOMAIN);
#endif
}


/**
 * @brief SHAKE-256 with incremental API and domain separation
 *
 * Derived from function SHAKE_256 in fips202.c
 *
 * @param[out] state Internal state of SHAKE
 * @param[in] output Pointer to output
 * @param[in] input Pointer to input
 * @param[in] inlen length of input in bytes
 * @param[in] domain byte for domain separation
 */
void shake256_512_ds(shake256incctx *state, uint8_t *output, const uint8_t *input, size_t inlen, uint8_t domain) {
    /* Init state */
    shake256_inc_init(state);

    /* Absorb input */
    shake256_inc_absorb(state, input, inlen);

    /* Absorb domain separation byte */
    shake256_inc_absorb(state, &domain, 1);

    /* Finalize */
    shake256_inc_finalize(state);

    /* Squeeze output */
    shake256_inc_squeeze(output, 512 / 8, state);
}
