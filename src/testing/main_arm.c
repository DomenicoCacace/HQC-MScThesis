#include <stdio.h>

#include "../common/api.h"
#include "../common/parameters.h"
#include "../common/vector.h"
#include "../fields/gf2x.h"
#include "../hqc/hqc.h"
#include "../lib/shake_ds.h"
#include "board_utils.h"

#ifdef TIMING
#include "timing.h"
void pke_timing(void);
void kem_timing(void);
void mul_timing(void);
#endif

#define BATCH_SIZE 3

int main(void) {
  setup_board();
#ifdef TIMING
#ifdef PKE
	pke_timing();
#endif
#ifdef KEM
	kem_timing();
#endif
#ifdef MUL
	mul_timing();
#endif
	return 0;
#else
/*
 * TODO: add functions to run encrypt/decrypt and encaps/decaps
 * on their own without timing nor debug, for lab tests
 */
#endif

}

#ifdef TIMING
void kem_timing() {
	unsigned char pk[PUBLIC_KEY_BYTES];
	unsigned char sk[SECRET_KEY_BYTES];
	unsigned char ct[CIPHERTEXT_BYTES];
	unsigned char key1[SHARED_SECRET_BYTES];
	unsigned char key2[SHARED_SECRET_BYTES];

	welford_t encaps;
	welford_t decaps;
	welford_init(&encaps);
	welford_init(&decaps);
	uint32_t start;
	uint32_t end;

	int passed = 0;

	trigger_set();
	for (int i = 0; i < BATCH_SIZE; i++) {
		crypto_kem_keypair(pk, sk);

		start = get_systick();
		crypto_kem_enc(ct, key1, pk);
		end = get_systick();
		welford_update(&encaps, (long double)(end-start));

		start = get_systick();
		crypto_kem_dec(key2, ct, sk);
		end = get_systick();
		welford_update(&decaps, (long double)(end-start));

		if (memcmp(key1, key2, SHARED_SECRET_BYTES) == 0) {
			passed++;
		}
	}
	trigger_reset();

	debug("Passed/Total: %d/%d\n\n", passed, BATCH_SIZE);
	debug("Algorithm\tExec Time\tVariance\n");
	debug("Encaps\t\t");
	welford_print(encaps);
	debug("Decaps\t\t");
	welford_print(decaps);
}

void pke_timing() {
	unsigned char pk[PUBLIC_KEY_BYTES];
  unsigned char sk[SECRET_KEY_BYTES];
  uint64_t m_in[VEC_K_SIZE_64] = {0};
	uint64_t m_out[VEC_K_SIZE_64] = {0};
  uint8_t theta[SHAKE256_512_BYTES] = {0};
  uint64_t u[VEC_N_SIZE_64] = {0};
  uint64_t v[VEC_N1N2_SIZE_64] = {0};
  shake256incctx shake256state;

  welford_t encrypt;
  welford_t decrypt;
  welford_init(&encrypt);
  welford_init(&decrypt);
  uint32_t start;
	uint32_t end;

  int passed = 0;

  trigger_set();
  for (int i = 0; i < BATCH_SIZE; i++) {
    hqc_pke_keygen(pk, sk);

		vect_set_random_from_prng(m_in);
		shake256_512_ds(&shake256state, theta, (uint8_t*) m_in, VEC_K_SIZE_BYTES, G_FCT_DOMAIN);
		start = get_systick();
		hqc_pke_encrypt(u, v, m_in, theta, pk);
		end = get_systick();
		welford_update(&encrypt, ((long double)(end-start)));

		start = get_systick();
		hqc_pke_decrypt(m_out, u, v, sk);
		end = get_systick();
		welford_update(&decrypt, ((long double)(end-start)));

		if (memcmp(m_in, m_out, VEC_K_SIZE_BYTES) == 0) {
			passed++;
		}
  }
  trigger_reset();

  debug("Passed/Total: %d/%d\n\n", passed, BATCH_SIZE);
  debug("Algorithm\tExec Time\t\tVariance\n");
  debug("Encrypt\t\t");
  welford_print(encrypt);
  debug("Decrypt\t\t");
  welford_print(decrypt);
}

void mul_timing() {
	#define MUL_ORIGINAL vect_mul
	#define MUL_OPTIMIZED opt_mul

	uint64_t u[VEC_N_SIZE_64] = {0};
	uint32_t y[PARAM_OMEGA] = {0};
    uint64_t y_dense[VEC_N_SIZE_64] = {0};
	uint64_t res_original[VEC_N_SIZE_64] = {0};
	uint64_t res_optimized[VEC_N_SIZE_64] = {0};
	unsigned char sk[SECRET_KEY_BYTES];	// TODO check if can be removed
	seedexpander_state seedexpander;

	welford_t mul_original;
	welford_t mul_optimized;
	welford_init(&mul_original);
	welford_init(&mul_optimized);
	uint32_t start;
	uint32_t end;

	int passed = 0;

	seedexpander_init(&seedexpander, sk, SEED_BYTES);

	trigger_set();
	for(int i = 0; i < BATCH_SIZE; i++) {
		vect_set_random_fixed_weight_by_coordinates(&seedexpander, y, PARAM_OMEGA);
		vect_set_random_from_prng(u);
		memset(res_original, 0, VEC_N_SIZE_BYTES);
		memset(res_optimized, 0, VEC_N_SIZE_BYTES);
		memset(y_dense, 0, VEC_N_SIZE_BYTES);


        for (size_t j = 0; j < PARAM_OMEGA; ++j) {
            int32_t index = y[j] / 64;
            int32_t pos = y[j] % 64;
            y_dense[index] |= ((uint64_t) 1) << pos;
        }
		start = get_systick();
		MUL_ORIGINAL(res_original, y, u, PARAM_OMEGA, &seedexpander);
		end = get_systick();
		welford_update(&mul_original, ((long double)(end-start)));



		start = get_systick();
		MUL_OPTIMIZED(res_optimized, (uint32_t*)y_dense, u, PARAM_OMEGA, &seedexpander);
		end = get_systick();
		welford_update(&mul_optimized, ((long double)(end-start)));

		uint64_t diff[VEC_N_SIZE_64] = {0};
		vect_add(diff, res_original, res_optimized, VEC_N_SIZE_64);
		


		if (memcmp(res_original, res_optimized, VEC_N_SIZE_BYTES) == 0) {
			passed++;
		}
	}
	trigger_reset();

	debug("Passed/Total: %d/%d\n", passed, BATCH_SIZE);
	debug("Algorithm\t\tExec Time\t\tVariance\n");
	debug("Original\t\t");
	welford_print(mul_original);
	debug("Optimized\t\t");
	welford_print(mul_optimized);
}
#else
#endif
