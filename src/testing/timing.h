#pragma once
#include <math.h>
#include "board_utils.h"

typedef struct {
    long double mean;
    long double M2;
    long count;
} welford_t;

static inline
uint32_t get_systick(void) {
#ifdef TIMING
    return ARM_CM_DWT_CYCCNT;
#endif
}

static inline
void welford_init(welford_t* state) {
    state->mean = 0.0;
    state->M2 = 0.0;
    state->count = 0;
    return;
}

static inline
void welford_update(welford_t* state, long double sample) {
    long double delta, delta2;
    state->count = state->count + 1;
    delta = sample - state->mean;
    state->mean += delta / (long double)(state->count);
    delta2 = sample - state->mean;
    state->M2 += delta * delta2;
}

static inline
void welford_print(const welford_t state) {
    debug("%.2Lf \t %.2Lf\r\n",
           state.mean,
           sqrtl(state.M2/(long double)(state.count-1)));
}