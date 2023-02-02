#ifndef TIMING_TOOLS_H
#define TIMING_TOOLS_H

#include <math.h>
#include <stdint.h>
#include <stdlib.h>

#include "architecture_detect.h"

typedef struct {
    long double mean;
    long double M2;
    long count;
} welford_t;

static inline
uint32_t get_systick(void) {
#ifdef CORTEX_M4
    return dwt_read_cycle_counter();
#else
    unsigned long long result;
    __asm__ __volatile__(
        "rdtscp;"
        "shl $32, %%rdx;"
        "or %%rdx, %%rax"
        : "=a"(result)
        :
        : "%rcx", "%rdx");
    return result;
#endif
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
    #ifdef CORTEX_M4
    char mean[13], variance[13];
    gcvt(state.mean, 13, mean);
    gcvt(sqrtl(state.M2 / (long double) (state.count - 1)), 13, variance);
    PRINTF("%s,%s\r\n", mean, variance);
    #else
    PRINTF("%Lf,%Lf\r\n", state.mean, sqrtl(state.M2 / (long double) (state.count - 1)));
    #endif
}

#endif
