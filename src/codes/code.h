#ifndef CODE_H
#define CODE_H

/**
 * @file code.h
 * Header file of code.c
 */

#include <stddef.h>
#include <stdint.h>

#include "parameters.h"

void code_encode(DIGIT *codeword, const DIGIT *message);

void code_decode(DIGIT *message, const DIGIT *vector);

#endif
