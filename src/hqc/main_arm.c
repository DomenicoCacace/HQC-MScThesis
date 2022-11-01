#include <stdio.h>

#include "../common/api.h"
#include "../common/parameters.h"
#include "board_utils.h"
#include "timing.h"

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

#ifdef TIMING
   welford_t encaps;
   welford_t decaps;
   welford_init(&encaps);
   welford_init(&decaps);
   long int delta_t;
#endif

   int passed = 0;

   trigger_set();
   for (int i = 0; i < BATCH_SIZE; i++) {
      crypto_kem_keypair(pk, sk);

#ifdef TIMING
      delta_t = get_systick();
#endif
      crypto_kem_enc(ct, key1, pk);
#ifdef TIMING
      delta_t = get_systick() - delta_t;
      welford_update(&encaps, (long double)delta_t);
      delta_t = get_systick();
#endif 
      crypto_kem_dec(key2, ct, sk);
#ifdef TIMING
      delta_t = get_systick() - delta_t;
      welford_update(&decaps, (long double)delta_t);
#endif 
      if (memcmp(key1, key2, SHARED_SECRET_BYTES) == 0) {
            passed++;
        }
   }
   trigger_reset();

   debug("Passed/Total: %d/%d\n\n", passed, BATCH_SIZE);
#ifdef TIMING
   debug("Algorithm\tExec Time\n");
   debug("Encaps");
   debug("\t\t%d\n", (int)encaps.mean);
   debug("Decaps");
   debug("\t\t%d\n", (int)decaps.mean);
#endif
}
