#include <string.h>
#include <stdio.h>
#include "../common/api.h"
#include "../common/parameters.h"
#include "../lib/shake_prng.h"

#define BATCH_SIZE 10000

int main(void) {
    unsigned char pk[PUBLIC_KEY_BYTES];
    unsigned char sk[SECRET_KEY_BYTES];
    unsigned char ct[CIPHERTEXT_BYTES];
    unsigned char key1[SHARED_SECRET_BYTES];
    unsigned char key2[SHARED_SECRET_BYTES];

	// "Generate" entropy for the prng
    uint8_t entropy_input[128];
    for (int i=0; i<128; i++)
        entropy_input[i] = i;
    shake_prng_init(entropy_input, entropy_input, 128, 64);


    int passed = 0;
    printf("Running functional test - %d iterations \r\n\r\n", BATCH_SIZE);

    for(int i = 0; i < BATCH_SIZE; i++) {
        crypto_kem_keypair(pk, sk);
        crypto_kem_enc(ct, key1, pk);
        crypto_kem_dec(key2, ct, sk);

#ifdef VERBOSE
        printf("Round %d\r\n", i+1);
        printf("secret1: ");
        for(int j = 0 ; j < SHARED_SECRET_BYTES ; ++j) printf("%x", key1[j]);

        printf("\r\nsecret2: ");
        for(int j = 0 ; j < SHARED_SECRET_BYTES ; ++j) printf("%x", key2[j]);
        printf("\r\n\r\n");
#endif

        if (memcmp(key1, key2, SHARED_SECRET_BYTES) == 0) {
            passed++;
        }
    }
      
    printf("Passed/Total: %d/%d\n", passed, BATCH_SIZE);
    return passed-BATCH_SIZE;
}
