#pragma once

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

void setup_board(void);

void setup_gpio(void);

void setup_usart(void);

void setup_systick(void);

void usart_send_str(char *str, int bytes);

void usart_recv_str(char *str, int bytes);

void trigger_set(void);

void trigger_reset(void);

void debug(const char *str, ...);
