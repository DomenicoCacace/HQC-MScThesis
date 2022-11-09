#include <string.h>
#include <stdio.h>
#include "../common/api.h"
#include "../common/parameters.h"
#include "../common/vector.h"
#include "../fields/gf2x.h"
#include "../lib/shake_prng.h"

#define BATCH_SIZE 2

int kem(void);
int pke(void);
int mul(void);

int main(void) {
    return mul();
}

int kem(void) {
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

int pke(void) {
    return 0;
}

int mul(void) {
    #define MUL_ORIGINAL vect_mul
	#define MUL_OPTIMIZED vect_mul

	uint64_t u[VEC_N_SIZE_64] = {0};
	uint32_t y[PARAM_OMEGA] = {0};
	uint64_t res_original[VEC_N_SIZE_64] = {0};
	uint64_t res_optimized[VEC_N_SIZE_64] = {0};
	unsigned char sk[SECRET_KEY_BYTES];	// TODO check if can be removed
	seedexpander_state seedexpander;

	int passed = 0;

	seedexpander_init(&seedexpander, sk, SEED_BYTES);

	for(int i = 0; i < BATCH_SIZE; i++) {
		vect_set_random_fixed_weight_by_coordinates(&seedexpander, y, PARAM_OMEGA);
		vect_generate_random_for_mult(u);

		MUL_ORIGINAL(res_original, y, u, PARAM_OMEGA, &seedexpander);
		MUL_OPTIMIZED(res_optimized, y, u, PARAM_OMEGA, &seedexpander);

#ifdef VERBOSE
    printf("\n\nu: ");
    for(int j = 0 ; j < VEC_N_SIZE_64 ; ++j) printf("%02lx ", u[j]);
    printf("\r\ny: ");
    for(int j = 0 ; j < PARAM_OMEGA ; ++j) printf("%d ", y[j]);
    printf("\r\n res_original: ");
    for(int j = 0 ; j < VEC_N_SIZE_64 ; ++j) printf("%02lx ", res_original[j]);
    printf("\r\nres_optimized: ");
    for(int j = 0 ; j < VEC_N_SIZE_64 ; ++j) printf("%02lx ", res_optimized[j]);
#endif


        if (memcmp(res_original, res_optimized, VEC_N_SIZE_BYTES) == 0) {
            passed++;
        }
	}
#ifdef VERBOSE
	printf("\n\nPassed/Total: %d/%d\n", passed, BATCH_SIZE);
#endif

    return passed-BATCH_SIZE;
}
