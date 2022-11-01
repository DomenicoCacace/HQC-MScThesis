#include <stdio.h>

#include "../common/api.h"
#include "../common/parameters.h"
#include "board_utils.h"

#define BATCH_SIZE 100
#define DELAY 5000

void run_pke(void);
void run_kem(void);

int main(void) {
   setup_board();
   #ifdef PKE
      run_pke();
   #endif

   #ifdef KEM
      run_kem();
   #endif
}

void run_kem() {
	unsigned char pk[PUBLIC_KEY_BYTES];
	unsigned char sk[SECRET_KEY_BYTES];
	unsigned char ct[CIPHERTEXT_BYTES];
	unsigned char key1[SHARED_SECRET_BYTES];
	unsigned char key2[SHARED_SECRET_BYTES];

   int passed = 0;

   for (int i = 0; i < BATCH_SIZE; i++) {
      trigger_set();
      crypto_kem_keypair(pk, sk);
      crypto_kem_enc(ct, key1, pk);
      crypto_kem_dec(key2, ct, sk);
      trigger_reset();

      if (memcmp(key1, key2, SHARED_SECRET_BYTES) == 0) {
            passed++;
        }
   }
   
   usart_send_str("Passed/Total: ", 14);
   char str[15];
   sprintf(str, "%d/%d", passed, BATCH_SIZE);
   usart_send_str(str, strlen(str));
}
