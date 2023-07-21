#ifndef HQC_H
#define HQC_H

/**
 * @file hqc.h
 * @brief Functions of the HQC_PKE IND_CPA scheme
 */

#include "parameters.h"

void hqc_pke_keygen(unsigned char *pk, unsigned char *sk);

void hqc_pke_encrypt(DIGIT *u, DIGIT *v, DIGIT *m, unsigned char *theta, const unsigned char *pk);

uint8_t hqc_pke_decrypt(DIGIT *m, uint8_t *sigma, const DIGIT *u, const DIGIT *v, const unsigned char *sk);

#endif
