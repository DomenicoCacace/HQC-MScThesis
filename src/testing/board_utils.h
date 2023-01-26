#ifndef BOARD_UTILS_H
#define BOARD_UTILS_H

#pragma once
/**
 * @file board_utils.h
 * @brief Header file of board_utils.c
*/

#include <libopencm3/stm32/flash.h>
#include <libopencm3/stm32/gpio.h>
#include <libopencm3/stm32/pwr.h>
#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/rng.h>
#include <libopencm3/stm32/timer.h>
#include <libopencm3/stm32/usart.h>
#include <stdarg.h>
#include <stdio.h>
#include <string.h>

// USART COMMUNICATION
#ifdef STLINK_COMM

#define USART USART2
#define RCC_USART RCC_USART2

#elif USART2_COMM
/* Enables USART 2
* place board as described above, same column of pins as the trigger,
* the LAST pin is RX, the penultimate one is TX
* the closest digital GND is the tenth from the bottom on the
* other column of pins of the same connector */
#define USART USART1
#define RCC_USART RCC_USART1
#else
#warning "No communication method defined"
#endif

void setup_board(void);

void trigger_set(void);

void trigger_reset(void);

void debug(const char *str, ...);

struct rcc_clock_scale {
        uint8_t pllm;
        uint16_t plln;
        uint8_t pllp;
        uint8_t pllq;
        uint8_t pllr;
        uint8_t pll_source;
        uint32_t flash_config;
        uint8_t hpre;
        uint8_t ppre1;
        uint8_t ppre2;
        enum pwr_vos_scale voltage_scale;
        uint32_t ahb_frequency;
        uint32_t apb1_frequency;
        uint32_t apb2_frequency;
};

enum rcc_clock_l476rg {
        RCC_CLOCK_L476RG_80MHz,
        RCC_CLOCK_L476RG_20MHz,
        RCC_CLOCK_L476RG_END
};
 
#endif
