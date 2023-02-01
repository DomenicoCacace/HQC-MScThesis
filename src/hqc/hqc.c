/**
 * @file hqc.c
 * @brief Implementation of hqc.h
 */

#include <stdint.h>

#include "architecture_detect.h"
#include "code.h"
#include "gf2x.h"
#include "hqc.h"
#include "parsing.h"
#include "vector.h"


/**
 * @brief Keygen of the HQC_PKE IND_CPA scheme
 *
 * The public key is composed of the syndrome <b>s</b> as well as the <b>seed</b> used to generate the vector <b>h</b>.
 *
 * The secret key is composed of the <b>seed</b> used to generate vectors <b>x</b> and  <b>y</b>.
 * As a technicality, the public key is appended to the secret key in order to respect NIST API.
 *
 * @param[out] pk String containing the public key
 * @param[out] sk String containing the secret key
 */
void hqc_pke_keygen(unsigned char *pk, unsigned char *sk) {
    seedexpander_state sk_seedexpander;
    seedexpander_state pk_seedexpander;
    uint8_t sk_seed[SEED_BYTES] = {0};
    uint8_t pk_seed[SEED_BYTES] = {0};
    DIGIT x[VEC_N_SIZE_DIGIT] = {0};
    shares_n_t y;
    DIGIT h[VEC_N_SIZE_DIGIT] = {0};
    shares_n_t s;

    shares_n_init(&y);
    shares_n_init(&s);

    // Create seed_expanders for public key and secret key
    randombytes(sk_seed, SEED_BYTES);
    seedexpander_init(&sk_seedexpander, sk_seed, SEED_BYTES);

    randombytes(pk_seed, SEED_BYTES);
    seedexpander_init(&pk_seedexpander, pk_seed, SEED_BYTES);

    // Compute secret key
    vect_set_random_fixed_weight(&sk_seedexpander, x, PARAM_OMEGA);
    vect_set_random_fixed_weight(&sk_seedexpander, y.s0, PARAM_OMEGA);
    shares_init_from_data(&y, y.s0);

    // Compute public key
    vect_set_random(&pk_seedexpander, h);
    shares_vec_mul(&s, &y, h);
    shares_n_collapse(s.s0, &s, x);

    // Parse keys to string
    hqc_public_key_to_string(pk, pk_seed, s.s0);
    hqc_secret_key_to_string(sk, sk_seed, pk);

    #ifdef VERBOSE
    PRINTF("\n\nsk_seed: ");
    for(int i = 0 ; i < SEED_BYTES ; ++i) PRINTF("%02x", sk_seed[i]);
    PRINTF("\n\nx: ");
    vect_print(x, VEC_N_SIZE_BYTES);
    PRINTF("\n\ny: ");
    vect_print(y, VEC_N_SIZE_BYTES);

    PRINTF("\n\npk_seed: ");
    for (int i = 0; i < SEED_BYTES; ++i) PRINTF("%02x", pk_seed[i]);
    PRINTF("\n\nh: ");
    vect_print(h, VEC_N_SIZE_BYTES);
    PRINTF("\n\ns: ");
    vect_print(s, VEC_N_SIZE_BYTES);

    PRINTF("\n\nsk: ");
    for (int i = 0; i < SECRET_KEY_BYTES; ++i) PRINTF("%02x", sk[i]);
    PRINTF("\n\npk: ");
    for (int i = 0; i < PUBLIC_KEY_BYTES; ++i) PRINTF("%02x", pk[i]);
#endif
}


/**
 * @brief Encryption of the HQC_PKE IND_CPA scheme
 *
 * The cihertext is composed of vectors <b>u</b> and <b>v</b>.
 *
 * @param[out] u Vector u (first part of the ciphertext)
 * @param[out] v Vector v (second part of the ciphertext)
 * @param[in] m Vector representing the message to encrypt
 * @param[in] theta Seed used to derive randomness required for encryption
 * @param[in] pk String containing the public key
 */
void hqc_pke_encrypt(DIGIT *u, DIGIT *v, DIGIT *m, unsigned char *theta, const unsigned char *pk) {
    seedexpander_state seedexpander;
    DIGIT h[VEC_N_SIZE_DIGIT] = {0};
    DIGIT s[VEC_N_SIZE_DIGIT] = {0};
    DIGIT e[VEC_N_SIZE_DIGIT] = {0};
    shares_n_t r1;
    shares_n_t r2;
    shares_n_t tmp1;
    shares_n_t tmp2;
    shares_n1n2_t _v;
    shares_k_t _m;

    shares_n_init(&r1);
    shares_n_init(&r2);
    shares_n1n2_init(&_v);
    shares_k_init(&_m);
    shares_n_init(&tmp1);
    shares_n_init(&tmp2);

    // Create seed_expander from theta
    seedexpander_init(&seedexpander, theta, SEED_BYTES);

    // Retrieve h and s from public key
    hqc_public_key_from_string(h, s, pk);

    // Generate r1, r2 and e
    vect_set_random_fixed_weight(&seedexpander, r1.s0, PARAM_OMEGA_R);
    vect_set_random_fixed_weight(&seedexpander, r2.s0, PARAM_OMEGA_R);
    vect_set_random_fixed_weight(&seedexpander, e, PARAM_OMEGA_E);
    shares_init_from_data(&r1, r1.s0);
    shares_init_from_data(&r2, r2.s0);

    // Compute u = r1 + r2.h
    shares_vec_mul(&tmp1, &r2, h);
    shares_add(&tmp1, &tmp1, &r1);
    shares_collapse_nosum(u, &tmp1);

    // Compute v = m.G by encoding the message
    shares_n_init(&tmp1);
    shares_init_from_msg(&_m, m);
    code_encode_shares(&_v, &_m);
    shares_resize_n(&tmp1, &_v);

    // Compute v = m.G + s.r2 + e
    shares_vec_mul(&tmp2, &r2, s);
    shares_add(&tmp1, &tmp1, &tmp2);
    shares_n_collapse(tmp1.s0, &tmp1, e);
    vect_resize(v, PARAM_N1N2, tmp1.s0, PARAM_N);

#ifdef VERBOSE
    PRINTF("\n\nh: ");
    vect_print(h, VEC_N_SIZE_BYTES);
    PRINTF("\n\ns: ");
    vect_print(s, VEC_N_SIZE_BYTES);
    PRINTF("\n\nr1: ");
    vect_print(r1, VEC_N_SIZE_BYTES);
    PRINTF("\n\nr2: ");
    vect_print_sparse(r2, PARAM_OMEGA_R);
    PRINTF("\n\ne: ");
    vect_print(e, VEC_N_SIZE_BYTES);
    PRINTF("\n\ntmp2: ");
    vect_print(tmp2, VEC_N_SIZE_BYTES);

    PRINTF("\n\nu: ");
    vect_print(u, VEC_N_SIZE_BYTES);
    PRINTF("\n\nv: ");
    vect_print(v, VEC_N1N2_SIZE_BYTES);
#endif
}


/**
 * @brief Decryption of the HQC_PKE IND_CPA scheme
 *
 * @param[out] m Vector representing the decrypted message
 * @param[in] u Vector u (first part of the ciphertext)
 * @param[in] v Vector v (second part of the ciphertext)
 * @param[in] sk String containing the secret key
 */
void hqc_pke_decrypt(DIGIT *m, const DIGIT *u, const DIGIT *v, const unsigned char *sk) {
    DIGIT x[VEC_N_SIZE_DIGIT] = {0};
    uint8_t pk[PUBLIC_KEY_BYTES] = {0};
    shares_n_t y;
    DIGIT _v[VEC_N_SIZE_DIGIT] = {0};
    shares_k_t _m;
    shares_n1n2_t c;
    shares_n_t tmp1;

    // Retrieve x, y, pk from secret key
    shares_n_init(&y);
    hqc_secret_key_from_string(x, y.s0, pk, sk);
    shares_init_from_data(&y, y.s0);

    // Generate and encode a random codeword
    shares_init_random_msg(&_m);
    shares_n1n2_init(&c);
    code_encode_shares(&c, &_m);

    // Mask v with the encoded random codeword
    shares_n_init(&tmp1);
    vect_resize(_v, PARAM_N, v, PARAM_N1N2);
    shares_resize_n(&tmp1, &c);
    shares_n_collapse(_v, &tmp1, _v);

    // Compute u.y
    shares_n_init(&tmp1);
    shares_vec_mul(&tmp1, &y, u);

    // Compute v - u.y
    shares_n_collapse(_v, &tmp1, _v);

    // Decode v - u.y
    //shares_n_init(&tmp1);
    code_decode(m, _v);
    shares_collapse_msg(m, &_m, m);
}
