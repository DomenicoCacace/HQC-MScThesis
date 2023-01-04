#ifndef PARSING_H
#define PARSING_H

/**
 * @file parsing.h
 * @brief Header file for parsing.c
 */

#include <stdint.h>

void hqc_secret_key_to_string(uint8_t *sk, const uint8_t *sk_seed, const uint8_t *pk);
void hqc_secret_key_from_string(uint32_t *x, uint32_t *y, uint8_t *pk, const uint8_t *sk);

void hqc_public_key_to_string(uint8_t *pk, const uint8_t *pk_seed, const uint32_t *s);
void hqc_public_key_from_string(uint32_t *h, uint32_t *s, const uint8_t *pk);

void hqc_ciphertext_to_string(uint8_t *ct, const uint32_t *u, const uint32_t *v, const uint8_t *d);
void hqc_ciphertext_from_string(uint32_t *u, uint32_t *v, uint8_t *d, const uint8_t *ct);

#endif
