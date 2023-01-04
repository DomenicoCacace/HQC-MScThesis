#ifndef REED_MULLER_H
#define REED_MULLER_H

/**
 * @file reed_muller.h
 * @brief Header file of reed_muller.c
 */

#include <stddef.h>
#include <stdint.h>

#include "../common/parameters.h"

void reed_muller_encode(uint32_t* cdw, const uint32_t* msg);
void reed_muller_decode(uint32_t* msg, const uint32_t* cdw);

#endif
