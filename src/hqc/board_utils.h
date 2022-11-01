#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>
#include <libopencm3/stm32/usart.h>
#include <libopencm3/stm32/f4/rcc.h>
#include <string.h>
#include <stdarg.h>
#include <stdio.h>

void setup_board(void);
void setup_gpio(void);
void setup_usart(void);
void usart_send_str(char *str, int bytes);
void usart_recv_str(char* str, int bytes);
void trigger_set(void);
void trigger_reset(void);
void debug(const char *str, ...);
