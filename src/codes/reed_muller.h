#ifndef REED_MULLER_H
#define REED_MULLER_H

/**
 * @file reed_muller.h
 * @brief Header file of reed_muller.c
 */

#include <stddef.h>

#include "parameters.h"

void reed_muller_encode(DIGIT *cdw, const DIGIT *msg);

void reed_muller_decode(DIGIT *msg, const DIGIT *cdw);

#endif
