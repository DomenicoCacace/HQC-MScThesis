/**
 * @file board_utils.c
 * @brief Tools to set up and operate the board
 */

#include "board_utils.h"

void setup_clock(const struct rcc_clock_scale *clock);

void setup_gpio(void);

void setup_usart(void);

void setup_systick(void);

void setup_trng(void);

void usart_send_str(char *str, int bytes);

void usart_recv_str(char *str, int bytes);

const struct rcc_clock_scale rcc_l476rg[RCC_CLOCK_L476RG_END] = {
        { /* 80MHz */
            .pllm = 2,
            .plln = 20,
            .pllp = RCC_PLLCFGR_PLLP_DIV7,
            .pllq = RCC_PLLCFGR_PLLQ_DIV8,
            .pllr = RCC_PLLCFGR_PLLR_DIV2,
            .pll_source = RCC_PLLCFGR_PLLSRC_HSI16,
            .hpre = RCC_CFGR_HPRE_NODIV,
            .ppre1 = RCC_CFGR_PPRE1_DIV2,
            .ppre2 = RCC_CFGR_PPRE2_NODIV,
            .voltage_scale = PWR_SCALE1,
            .flash_config = FLASH_ACR_DCEN | FLASH_ACR_ICEN |
                            FLASH_ACR_LATENCY_4WS,
            .ahb_frequency  = 80000000,
            .apb1_frequency = 40000000,
            .apb2_frequency = 80000000,
        },
        {   /* 64 MHz*/
            .pllm = 2,
            .plln = 32,
            .pllp = RCC_PLLCFGR_PLLP_DIV7,
            .pllq = RCC_PLLCFGR_PLLQ_DIV8,
            .pllr = RCC_PLLCFGR_PLLR_DIV4,
            .pll_source = RCC_PLLCFGR_PLLSRC_HSI16,
            .hpre = RCC_CFGR_HPRE_NODIV,
            .ppre1 = RCC_CFGR_PPRE1_DIV2,
            .ppre2 = RCC_CFGR_PPRE2_NODIV,
            .voltage_scale = PWR_SCALE1,
            .flash_config = FLASH_ACR_DCEN | FLASH_ACR_ICEN |
                            FLASH_ACR_LATENCY_3WS,
            .ahb_frequency  = 64000000,
            .apb1_frequency = 32000000,
            .apb2_frequency = 64000000,
        },
        {   /* 48 MHz*/
            .pllm = 2,
            .plln = 48,
            .pllp = RCC_PLLCFGR_PLLP_DIV7,
            .pllq = RCC_PLLCFGR_PLLQ_DIV8,
            .pllr = RCC_PLLCFGR_PLLR_DIV8,
            .pll_source = RCC_PLLCFGR_PLLSRC_HSI16,
            .hpre = RCC_CFGR_HPRE_NODIV,
            .ppre1 = RCC_CFGR_PPRE1_DIV2,
            .ppre2 = RCC_CFGR_PPRE2_NODIV,
            .voltage_scale = PWR_SCALE1,
            .flash_config = FLASH_ACR_DCEN | FLASH_ACR_ICEN |
                            FLASH_ACR_LATENCY_2WS,
            .ahb_frequency  = 48000000,
            .apb1_frequency = 24000000,
            .apb2_frequency = 48000000,
        },
        {   /* 32 MHz*/
            .pllm = 2,
            .plln = 32,
            .pllp = RCC_PLLCFGR_PLLP_DIV7,
            .pllq = RCC_PLLCFGR_PLLQ_DIV8,
            .pllr = RCC_PLLCFGR_PLLR_DIV8,
            .pll_source = RCC_PLLCFGR_PLLSRC_HSI16,
            .hpre = RCC_CFGR_HPRE_NODIV,
            .ppre1 = RCC_CFGR_PPRE1_DIV2,
            .ppre2 = RCC_CFGR_PPRE2_NODIV,
            .voltage_scale = PWR_SCALE1,
            .flash_config = FLASH_ACR_DCEN | FLASH_ACR_ICEN |
                            FLASH_ACR_LATENCY_1WS,
            .ahb_frequency  = 32000000,
            .apb1_frequency = 16000000,
            .apb2_frequency = 32000000,
        },
        {   /* 16 MHz*/
            .pllm = 2,
            .plln = 16,
            .pllp = RCC_PLLCFGR_PLLP_DIV7,
            .pllq = RCC_PLLCFGR_PLLQ_DIV8,
            .pllr = RCC_PLLCFGR_PLLR_DIV8,
            .pll_source = RCC_PLLCFGR_PLLSRC_HSI16,
            .hpre = RCC_CFGR_HPRE_NODIV,
            .ppre1 = RCC_CFGR_PPRE1_DIV2,
            .ppre2 = RCC_CFGR_PPRE2_NODIV,
            .voltage_scale = PWR_SCALE1,
            .flash_config = FLASH_ACR_DCEN | FLASH_ACR_ICEN |
                            FLASH_ACR_LATENCY_0WS,
            .ahb_frequency  = 16000000,
            .apb1_frequency = 8000000,
            .apb2_frequency = 16000000,
        }
};


void setup_board(void) {
    #define CLK_CFG &rcc_l476rg[CLOCK_SETTINGS]
    setup_clock(CLK_CFG);
    setup_gpio();
    setup_usart();
    setup_systick();
    setup_trng();
}

void setup_clock(const struct rcc_clock_scale *clock) {
    /* Set the voltage range */
    pwr_set_vos_scale(clock->voltage_scale);

    /* Enable the HSI16 clock */
    rcc_osc_on(RCC_HSI16);
    rcc_wait_for_osc_ready(RCC_HSI16);

    /* Set the HSI16 as the system clock source */
    rcc_set_sysclk_source(RCC_PLLCFGR_PLLSRC_HSI16);

    /*
    * Set prescalers for AHB, ADC, APB1, APB2.
    * Do this before touching the PLL (TODO: why?).
    */
    rcc_set_hpre(clock->hpre);
    rcc_set_ppre1(clock->ppre1);
    rcc_set_ppre2(clock->ppre2);

    /* Set the flash wait states */
   /* Configure flash settings. */
    if (clock->flash_config & FLASH_ACR_DCEN) {
            flash_dcache_enable();
    } else {
            flash_dcache_disable();
    }
    if (clock->flash_config & FLASH_ACR_ICEN) {
            flash_icache_enable();
    } else {
            flash_icache_disable();
    }
    flash_set_ws(clock->flash_config);

    /* Disable PLL oscillator before changing its configuration. */
    rcc_osc_off(RCC_PLL);

    /* Configure the PLL oscillator. */
    rcc_set_main_pll(clock->pll_source, clock->pllm, clock->plln, clock->pllp, clock->pllq, clock->pllr);
    /* Enable PLL oscillator and wait for it to stabilize. */
    rcc_osc_on(RCC_PLL);
    rcc_wait_for_osc_ready(RCC_PLL);

    /* Select PLL as SYSCLK source. */
    rcc_set_sysclk_source(RCC_CFGR_SWS_PLL);

    /* Wait for PLL clock to be selected. */
    rcc_wait_for_sysclk_status(RCC_PLL);
    trigger_set();

    /* Set the peripheral clock frequencies used. */
    rcc_ahb_frequency =  clock->ahb_frequency;
    rcc_apb1_frequency = clock->apb1_frequency;
    rcc_apb2_frequency = clock->apb2_frequency;

    /* Enable the 48MHz clock */
    rcc_set_msi_range(RCC_CR_MSIRANGE_48MHZ);
    rcc_osc_on(RCC_MSI);
    rcc_wait_for_osc_ready(RCC_MSI);
    rcc_set_clock48_source(RCC_CCIPR_CLK48SEL_MSI);
}

/* Sets up trigger GPIO as Port B - Pin 9 
 * place board with stlink on top, left morpho (male pin-header)
 * inner column of pins, third from top, with GND as fifth from top */
void setup_gpio(void) {
    // Prepare the USART1
    rcc_periph_clock_enable(RCC_GPIOA);
    gpio_mode_setup(GPIOA, GPIO_MODE_AF, GPIO_PUPD_PULLUP, GPIO9 | GPIO10);
    gpio_set_af(GPIOA, GPIO_AF7, GPIO9 | GPIO10);
    rcc_periph_clock_enable(RCC_GPIOB);

    rcc_periph_clock_enable(RCC_GPIOA);
    gpio_mode_setup(GPIOA, GPIO_MODE_AF, GPIO_PUPD_PULLUP, GPIO0 | GPIO1);
    gpio_set_af(GPIOA, GPIO_AF7, GPIO0 | GPIO1);

    // Prepare the Trigger GPIO
    rcc_periph_clock_enable(RCC_GPIOB);
    gpio_mode_setup(GPIOB, GPIO_MODE_OUTPUT, GPIO_PUPD_PULLUP, GPIO9);
    gpio_clear(GPIOB, GPIO9);

    // Prepare the LED GPIO
    rcc_periph_clock_enable(RCC_GPIOA);
    gpio_mode_setup(GPIOA, GPIO_MODE_OUTPUT, GPIO_PUPD_NONE, GPIO5);

    // Prepare the UART GPIO
    rcc_periph_clock_enable(RCC_GPIOA);
    gpio_mode_setup(GPIOA, GPIO_MODE_AF, GPIO_PUPD_NONE, GPIO2);
    gpio_set_af(GPIOA, GPIO_AF7, GPIO2);

}

void setup_usart(void) {
// Enable the UART clock
    rcc_periph_clock_enable(RCC_USART);
// We need a brief delay before we can access UART config registers
    __asm__ volatile ("nop;nop;nop;nop;nop;":: : "memory");
// Disable the UART while we mess with its settings
    usart_disable(USART);
// Configure the UART clock source as precision internal oscillator
// usart_clock_from_piosc();
// Set communication parameters
    usart_set_baudrate(USART, 9600);
    usart_set_databits(USART, 8);
    usart_set_parity(USART, USART_PARITY_NONE);
    usart_set_mode(USART, USART_MODE_TX_RX);
    usart_set_stopbits(USART, USART_STOPBITS_1);
// Disable RTC and CTS lines
    usart_set_flow_control(USART, USART_FLOWCONTROL_NONE);
// Now that we're done messing with the settings, enable the UART
    usart_enable(USART);
    // usart_disable_error_interrupt(USART1);
    // usart_disable_idle_interrupt(USART1);
    // usart_disable_rx_interrupt(USART1);
    // usart_disable_tx_interrupt(USART1);
}

void setup_systick(void) {
#ifdef TIMING
    dwt_enable_cycle_counter();
#endif
}

void setup_trng(void) {
   rcc_periph_clock_enable(RCC_RNG);
   rng_enable();
   rng_interrupt_enable();
}

void usart_send_str(char *str, int bytes) {
    for (int i = 0; i < bytes; i++)
        usart_send_blocking(USART, str[i]);
}

void usart_recv_str(char *str, int bytes) {
    for (int i = 0; i < bytes; ++i)
        str[i] = usart_recv_blocking(USART);
}

void trigger_set(void) {
    gpio_set(GPIOB, GPIO9);
    gpio_set(GPIOA, GPIO5);
}

void trigger_reset(void) {
    gpio_clear(GPIOB, GPIO9);
    gpio_clear(GPIOA, GPIO5);
}

void delay_cycles(uint32_t cycles) {
    uint32_t start = dwt_read_cycle_counter();
    while (dwt_read_cycle_counter() - start < cycles);
}

void delay_us(uint32_t us) {
    uint32_t start = dwt_read_cycle_counter();
    uint32_t cycles = us * (rcc_ahb_frequency / 1000000);
    while (dwt_read_cycle_counter() - start < cycles);
}

void debug(const char *str, ...) {
#ifdef DEBUG
    char buffer[256];
    va_list arg;

    va_start (arg, str);
    vsprintf (buffer, str, arg);
    va_end (arg);

    usart_send_str(buffer, strlen(buffer));
#endif
}


