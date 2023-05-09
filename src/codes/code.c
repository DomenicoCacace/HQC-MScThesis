/**
 * @file code.c
 * @brief Implementation of concatenated code
 */

#include <stdint.h>

#include "code.h"
#include "reed_muller.h"
#include "reed_solomon.h"


/**
 *
 * @brief Encoding the message m to a code word em using the concatenated code
 *
 * First we encode the message using the Reed-Solomon code, then with the duplicated Reed-Muller code we obtain
 * a concatenated code word.
 *
 * @param[out] em Pointer to an array that is the tensor code word
 * @param[in] m Pointer to an array that is the message
 */
void code_encode(DIGIT *em, const DIGIT *m) {
    DIGIT tmp[VEC_N1_SIZE_DIGIT] = {0};

    reed_solomon_encode(tmp, m);
    reed_muller_encode(em, tmp);

#ifdef VERBOSE
    PRINTF("\n\nReed-Solomon code word: ");
    vect_print(tmp, VEC_N1_SIZE_BYTES);
    PRINTF("\n\nConcatenated code word: ");
    vect_print(em, VEC_N1N2_SIZE_BYTES);
#endif
}

void code_encode_shares(shares_n1n2_t *em, shares_k_t *m) {
#if SHARES == 1
    code_encode(em->s0, m->s0);
#elif SHARES == 2
    code_encode(em->s0, m->s0);
	code_encode(em->s1, m->s1);
#else
#error TOO_MANY_SHARES
#endif
}

/**
 * @brief Decoding the code word em to a message m using the concatenated code
 *
 * @param[out] m Pointer to an array that is the message
 * @param[in] em Pointer to an array that is the code word
 */
void code_decode(DIGIT *m, const DIGIT *em) {
    DIGIT tmp[VEC_N1_SIZE_DIGIT] = {0};

    reed_muller_decode(tmp, em);
    reed_solomon_decode(m, tmp);


#ifdef VERBOSE
    PRINTF("\n\nReed-Muller decoding result (the input for the Reed-Solomon decoding algorithm): ");
    vect_print(tmp, VEC_N1_SIZE_BYTES);
#endif
}
