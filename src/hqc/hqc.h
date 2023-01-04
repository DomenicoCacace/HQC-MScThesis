#ifndef HQC_H
#define HQC_H

/**
 * @file hqc.h
 * @brief Functions of the HQC_PKE IND_CPA scheme
 */

#include <stdint.h>

void hqc_pke_keygen(unsigned char* pk, unsigned char* sk);
void hqc_pke_encrypt(uint32_t *u, uint32_t *v, uint32_t *m, unsigned char *theta, const unsigned char *pk);
void hqc_pke_decrypt(uint32_t *m, const uint32_t *u, const uint32_t *v, const unsigned char *sk);

#endif
