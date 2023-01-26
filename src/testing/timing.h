#pragma once

#include <math.h>
#include <stdlib.h>
#include "board_utils.h"

typedef struct {
    long double mean;
    long double M2;
    long count;
} welford_t;

static inline
uint32_t get_systick(void) {
    return dwt_read_cycle_counter();
}

static inline
void welford_init(welford_t *state) {
    state->mean = 0.0;
    state->M2 = 0.0;
    state->count = 0;
    return;
}

static inline
void welford_update(welford_t *state, long double sample) {
    long double delta, delta2;
    state->count = state->count + 1;
    delta = sample - state->mean;
    state->mean += delta / (long double) (state->count);
    delta2 = sample - state->mean;
    state->M2 += delta * delta2;
}

static inline
void welford_print(const welford_t state) {
    char mean[13], variance[13];
    gcvt(state.mean, 13, mean);
    gcvt(sqrtl(state.M2 / (long double) (state.count - 1)), 13, variance);
    debug("%s \t %s\r\n", mean, variance);
}
