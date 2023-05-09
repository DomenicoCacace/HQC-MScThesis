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
    #ifdef CORTEX_M4
    dwt_enable_cycle_counter();
    #endif
}

static inline
void welford_print(const welford_t state) {
    long double variance = state.M2 / (long double) (state.count - 1);
    PRINTF("%Lf,%Lf\r\n", state.mean, sqrtl(variance));
}

static inline
long double welch_t_statistic(const welford_t state1, const welford_t state2) {
    long double num, den, var1, var2;
    var1 = state1.M2/(long double)(state1.count-1);
    var2 = state2.M2/(long double)(state2.count-1);

    num = state1.mean - state2.mean;
    den = sqrtl(var1/(long double) state1.count + var2/(long double) state2.count );

    if(den == 0) {
        if(state1.mean != state2.mean)
            return INFINITY;
        return 0.0;
    }
    return num/den;
}

static inline
void welch_t_print(const welford_t state1, const welford_t state2) {
    long double t = welch_t_statistic(state1, state2);
    if (t == INFINITY) {
        double num = state1.mean - state2.mean;
        PRINTF("inf,num=%f\r\n", num);
    }
    else {
        PRINTF("%Lf\r\n", t);
    }
}
#endif
