/**
 * @file vector.c
 * @brief Implementation of vectors sampling and some utilities for the HQC scheme
 */

#include <stdint.h>
#include <string.h>

#include "architecture_detect.h"
#include "parameters.h"
#include "vector.h"

/**
 * @brief Constant-time comparison of two integers v1 and v2
 *
 * Returns 1 if v1 is equal to v2 and 0 otherwise
 * https://gist.github.cppom/sneves/10845247
 *
 * @param[in] v1 
 * @param[in] v2 
 */
static inline uint32_t compare_u32(const uint32_t v1, const uint32_t v2) {
    return 1 ^ (((v1 - v2)|(v2 - v1)) >> 31);
}

/**
 * @brief Generates a vector of a given Hamming weight
 *
 * This function generates uniformly at random a binary vector of a Hamming weight equal to the parameter <b>weight</b>. The vector
 * is stored by position.
 * To generate the vector we have to sample uniformly at random values in the interval [0, PARAM_N -1]. Suppose the PARAM_N is equal to \f$ 70853 \f$, to select a position \f$ r\f$ the function works as follow:
 *  1. It makes a call to the seedexpander function to obtain a random number \f$ x\f$ in \f$ [0, 2^{24}[ \f$.
 *  2. Let \f$ t = \lfloor {2^{24} \over 70853} \rfloor \times  70853\f$
 *  3. If \f$ x \geq t\f$, go to 1
 *  4. It return \f$ r = x \mod 70853\f$
 *
 * The parameter \f$ t \f$ is precomputed and it's denoted by UTILS_REJECTION_THRESHOLD (see the file parameters.h).
 *
 * @param[in] v Pointer to an array
 * @param[in] weight Integer that is the Hamming weight
 * @param[in] ctx Pointer to the context of the seed expander
 */
void vect_set_random_fixed_weight_by_coordinates(seedexpander_state *ctx, uint32_t *v, uint16_t weight) {
    uint32_t rand_u32[PARAM_OMEGA_R] = {0};

    seedexpander(ctx, (uint8_t *)&rand_u32, 4 * PARAM_OMEGA_R);

    for (size_t i = 0; i < weight; ++i) {
        v[i] = i + rand_u32[i] % (PARAM_N - i);
    }

    for (int32_t i = (weight - 1); i -- > 0;) {
        uint32_t found = 0;

        for (size_t j = i + 1; j < weight; ++j) {
            found |= compare_u32(v[j], v[i]);
        }

        uint32_t mask = -found;
        v[i] = (mask & i) ^ (~mask & v[i]);
    }
}


/**
 * @brief Generates a vector of a given Hamming weight
 *
 * This function generates uniformly at random a binary vector of a Hamming weight equal to the parameter <b>weight</b>.
 * To generate the vector we have to sample uniformly at random values in the interval [0, PARAM_N -1]. Suppose the PARAM_N is equal to \f$ 70853 \f$, to select a position \f$ r\f$ the function works as follow:
 *  1. It makes a call to the seedexpander function to obtain a random number \f$ x\f$ in \f$ [0, 2^{24}[ \f$.
 *  2. Let \f$ t = \lfloor {2^{24} \over 70853} \rfloor \times  70853\f$
 *  3. If \f$ x \geq t\f$, go to 1
 *  4. It return \f$ r = x \mod 70853\f$
 *
 * The parameter \f$ t \f$ is precomputed and it's denoted by UTILS_REJECTION_THRESHOLD (see the file parameters.h).
 *
 * @param[in] v Pointer to an array
 * @param[in] weight Integer that is the Hamming weight
 * @param[in] ctx Pointer to the context of the seed expander
 */
void vect_set_random_fixed_weight(seedexpander_state *ctx, DIGIT *v, uint16_t weight) {
    uint32_t tmp[PARAM_OMEGA_R] = {0};

    vect_set_random_fixed_weight_by_coordinates(ctx, tmp, weight);
    vect_sparse_to_dense(v, tmp, weight);
}

/**
 * @brief Generates a random vector of dimension <b>PARAM_N</b>
 *
 * This function generates a random binary vector of dimension <b>PARAM_N</b>. It generates a random
 * array of bytes using the seedexpander function, and drop the extra bits using a mask.
 *
 * @param[in] v Pointer to an array
 * @param[in] ctx Pointer to the context of the seed expander
 */
void vect_set_random(seedexpander_state *ctx, DIGIT *v) {
    uint8_t rand_bytes[VEC_N_SIZE_BYTES] = {0};

    seedexpander(ctx, rand_bytes, VEC_N_SIZE_BYTES);

    memcpy(v, rand_bytes, VEC_N_SIZE_BYTES);
    v[VEC_N_SIZE_DIGIT - 1] &= RED_MASK;
}


/**
 * @brief Generates a random vector
 *
 * This function generates a random binary vector. It uses the prng function.
 *
 * @param[in] v Pointer to an array
 */
void vect_set_random_from_prng(DIGIT *v) {
    uint8_t rand_bytes[VEC_K_SIZE_BYTES] = {0};

    randombytes(rand_bytes, VEC_K_SIZE_BYTES);
    memcpy(v, rand_bytes, VEC_K_SIZE_BYTES);
}

/**
 * @brief Generates a random vector representing a polynomial
 * of degree at most <b>PARAM_N</b>
*/
void vect_generate_random_for_mult(DIGIT *v) {
    uint8_t rand_bytes [VEC_N_SIZE_BYTES] = {0};

    randombytes(rand_bytes, VEC_N_SIZE_BYTES);
    memcpy(v, rand_bytes, VEC_N_SIZE_BYTES);
    v[VEC_N_SIZE_DIGIT-1] &= RED_MASK;
}

/**
 * @brief Adds two vectors
 *
 * @param[out] o Pointer to an array that is the result
 * @param[in] v1 Pointer to an array that is the first vector
 * @param[in] v2 Pointer to an array that is the second vector
 * @param[in] size Integer that is the size of the vectors
 */
void vect_add(DIGIT *o, const DIGIT *v1, const DIGIT *v2, uint32_t size) {
    for (uint32_t i = 0; i < size; ++i) {
        o[i] = v1[i] ^ v2[i];
    }
}


/**
 * @brief Compares two vectors
 *
 * @param[in] v1 Pointer to an array that is first vector
 * @param[in] v2 Pointer to an array that is second vector
 * @param[in] size Integer that is the size of the vectors
 * @returns 0 if the vectors are equals and a negative/psotive value otherwise
 */
uint8_t vect_compare(const uint8_t *v1, const uint8_t *v2, uint32_t size) {
    DIGIT r = 0;

    for (size_t i = 0; i < size; i++) {
        r |= v1[i] ^ v2[i];
    }

    r = (~r + 1) >> (DIGIT_SIZE_b-1);
    return (uint8_t) r;
}


/**
 * @brief Resize a vector so that it contains <b>size_o</b> bits
 *
 * @param[out] o Pointer to the output vector
 * @param[in] size_o Integer that is the size of the output vector in bits
 * @param[in] v Pointer to the input vector
 * @param[in] size_v Integer that is the size of the input vector in bits
 */
void vect_resize(DIGIT *o, uint32_t size_o, const DIGIT *v, uint32_t size_v) {
    int8_t val = 0;
    if (size_o < size_v) {

        if (size_o % DIGIT_SIZE_b) {
            val = DIGIT_SIZE_b - (size_o % DIGIT_SIZE_b);
        }

        memcpy(o, v, VEC_N1N2_SIZE_BYTES);

        for (int8_t i = 0; i < val; ++i) {
            o[VEC_N1N2_SIZE_DIGIT - 1] &= (RED_MASK >> i);
        }
    } else {
        memcpy(o, v, CEIL_DIVIDE(size_v, 8));
    }
}


/**
 * @brief Prints a given number of bytes
 *
 * @param[in] v Pointer to an array of bytes
 * @param[in] size Integer that is number of bytes to be displayed
 */
void vect_print(const DIGIT *v, const uint32_t size) {
    if (size == VEC_K_SIZE_BYTES) {
        uint8_t tmp[VEC_K_SIZE_BYTES] = {0};
        memcpy(tmp, v, VEC_K_SIZE_BYTES);
        for (uint32_t i = 0; i < VEC_K_SIZE_BYTES; ++i) {
            PRINTF("%02x", tmp[i]);
        }
    } else if (size == VEC_N_SIZE_BYTES) {
        uint8_t tmp[VEC_N_SIZE_BYTES] = {0};
        memcpy(tmp, v, VEC_N_SIZE_BYTES);
        for (uint32_t i = 0; i < VEC_N_SIZE_BYTES; ++i) {
            PRINTF("%02x", tmp[i]);
        }
    } else if (size == VEC_N1N2_SIZE_BYTES) {
        uint8_t tmp[VEC_N1N2_SIZE_BYTES] = {0};
        memcpy(tmp, v, VEC_N1N2_SIZE_BYTES);
        for (uint32_t i = 0; i < VEC_N1N2_SIZE_BYTES; ++i) {
            PRINTF("%02x", tmp[i]);
        }
    } else if (size == VEC_N1_SIZE_BYTES) {
        uint8_t tmp[VEC_N1_SIZE_BYTES] = {0};
        memcpy(tmp, v, VEC_N1_SIZE_BYTES);
        for (uint32_t i = 0; i < VEC_N1_SIZE_BYTES; ++i) {
            PRINTF("%02x", tmp[i]);
        }
    }
}


/**
 * @brief Prints a vector stored by positions
 *
 * @param[in] v Pointer to an array of integers
 * @param[in] weight Integer that is number positions to be displayed
 */
void vect_print_sparse(const uint32_t *v, const uint16_t weight) {
    for (uint16_t i = 0; i < weight - 1; ++i) {
        PRINTF("%d ,", v[i]);
    }
    PRINTF("%d", v[weight - 1]);
}


/**
 * @brief Converts a sparse vector to a dense vector
 * 
 * @param[out] dense Pointer to the dense vector
 * @param[in] sparse Pointer to the sparse vector
 * @param[in] weight Integer that is the Hamming weight
*/
void vect_sparse_to_dense(DIGIT *dense, const uint32_t *sparse, const uint16_t weight) {
    for (size_t i = 0; i < weight; ++i) {
        int32_t index = sparse[i] / DIGIT_SIZE_b;
        int32_t pos = sparse[i] % DIGIT_SIZE_b;
        dense[index] |= ((DIGIT) 1) << pos;
    }
}

