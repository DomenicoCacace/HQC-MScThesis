#include "board_utils.h"

void setup_board(void) {
   // HSE connects the PLL to an external High Speed oscillator, I believe.
   // Since there is none attached to the board...
   // rcc_clock_setup_pll(&rcc_hse_16mhz_3v3[RCC_CLOCK_3V3_84MHZ]);
   rcc_clock_setup_pll(&rcc_hsi_configs[RCC_CLOCK_3V3_84MHZ]);
   setup_gpio();
   setup_usart();
#ifdef TIMING
   setup_systick();
#endif
}

/* Sets up trigger GPIO as Port B - Pin 9 
 * place board with stlink on top, left morpho (male pin-header)
 * inner column of pins, third from top, with GND as fifth from top */
void setup_gpio(void){
   // Prepare the USART1
   rcc_periph_clock_enable(RCC_GPIOA);
   gpio_mode_setup(GPIOA, GPIO_MODE_AF, GPIO_PUPD_PULLUP, GPIO9|GPIO10);
   gpio_set_af(GPIOA, GPIO_AF7, GPIO9 | GPIO10);
   rcc_periph_clock_enable(RCC_GPIOB);

   rcc_periph_clock_enable(RCC_GPIOA);
   gpio_mode_setup(GPIOA, GPIO_MODE_AF, GPIO_PUPD_PULLUP, GPIO0|GPIO1);
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
   #error "No communication method defined"   
#endif


void setup_usart(void){
// Enable the UART clock
   rcc_periph_clock_enable(RCC_USART);
// We need a brief delay before we can access UART config registers
   __asm__ volatile ("nop;nop;nop;nop;nop;" ::: "memory");
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
    if (ARM_CM_DWT_CTRL != 0) {                  // See if DWT is available
        ARM_CM_DEMCR      |= 1 << 24;            // Set bit 24
        ARM_CM_DWT_CYCCNT  = 0;                
        ARM_CM_DWT_CTRL   |= 1 << 0;             // Set bit 0
    }
}

void usart_send_str(char *str, int bytes) {
  for (int i = 0; i < bytes; i++)
    usart_send_blocking(USART, str[i]);
}

void usart_recv_str(char* str, int bytes){
  for (int i = 0; i < bytes; ++i)
    str[i] = usart_recv_blocking(USART);  
}

void trigger_set(void){
  gpio_set(GPIOB, GPIO9);
  gpio_set(GPIOA, GPIO5);
}

void trigger_reset(void){
  gpio_clear(GPIOB, GPIO9);
  gpio_clear(GPIOA, GPIO5);
}

void debug(const char* str, ...){ 
   #ifdef DEBUG
   char buffer[256];
   va_list arg;

   va_start (arg, str);
   vsprintf (buffer, str, arg);
   va_end (arg);

   usart_send_str(buffer, strlen(buffer));
   #endif
}