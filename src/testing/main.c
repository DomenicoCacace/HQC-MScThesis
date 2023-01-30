/**
 * @file main_arm.c
 */

#include "architecture_detect.h"
#include "main.h"

#ifdef CORTEX_M4
#include "board_utils.h"
#endif

#define BATCH_SIZE 10

int main(void) {
#ifdef CORTEX_M4
    setup_board();
#endif
    return run(BATCH_SIZE);
}
