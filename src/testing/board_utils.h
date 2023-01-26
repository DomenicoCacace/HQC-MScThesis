#pragma once

#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>
#include <libopencm3/stm32/usart.h>
#include <libopencm3/stm32/flash.h>
#include <libopencm3/stm32/pwr.h>
#include <libopencm3/stm32/rng.h>
#include <string.h>
#include <stdarg.h>
#include <stdio.h>

#define  ARM_CM_DEMCR      (*(uint32_t *)0xE000EDFC)
#define  ARM_CM_DWT_CTRL   (*(uint32_t *)0xE0001000)
#define  ARM_CM_DWT_CYCCNT (*(uint32_t *)0xE0001004)

void setup_board(void);
void setup_clock(void);
void setup_gpio(void);
void setup_usart(void);
void setup_systick(void);
void setup_trng(void);
void usart_send_str(char *str, int bytes);
void usart_recv_str(char* str, int bytes);
void trigger_set(void);
void trigger_reset(void);
void debug(const char *str, ...);
