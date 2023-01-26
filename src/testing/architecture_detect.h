#ifndef ARCHITECTURE_DETECT_H
#define ARCHITECTURE_DETECT_H

/**
 * @file architecture_detect.h
 * @brief Utilities to detect the architecture and select the correct implementation
 */

#define FUNCTIONAL 0
#define TIMING 1
#define PLAIN 2


#ifdef CORTEX_M4
#include "board_utils.h"
#define PRINTF(...) debug(__VA_ARGS__)
#define TRIGGER_SET trigger_set();
#define TRIGGER_RESET trigger_reset();

#else
#include <stdio.h>
#define PRINTF(...) printf(__VA_ARGS__)
#define TRIGGER_SET
#define TRIGGER_RESET
#endif

#endif
