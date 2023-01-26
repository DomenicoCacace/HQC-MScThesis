/**
 * @file main_arm.c
 */

#include "architecture_detect.h"
#ifdef CORTEX_M4
#include "board_utils.h"
#endif

#define BATCH_SIZE 10

int main(void) {
#ifdef CORTEX_M4
    setup_board();
#endif
    run(BATCH_SIZE);
}
