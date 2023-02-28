/**
 * @file gf2x.c
 * @brief Implementation of multiplication of two polynomials
 */

#include <stdint.h>
#include <string.h>

#include "gf2x.h"

#define TABLE 16
#define WORD 64

static inline void swap(uint16_t *tab, uint16_t elt1, uint16_t elt2);

static void reduce(DIGIT *o, const DIGIT *a);
static void fast_convolution_mult(uint64_t *o, const uint32_t *a1, const uint64_t *a2, const uint16_t weight, seedexpander_state *ctx);
void base_mul(uint64_t *c, uint64_t a, uint64_t b);
void karatsuba_add2(uint64_t *o, uint64_t *tmp1, uint64_t* tmp2, uint64_t size_l, uint64_t size_h);
void karatsuba_add1(uint64_t *alh, uint64_t *blh, const uint64_t *a, const uint64_t *b, uint64_t size_l, uint64_t size_h);
void karatsuba(uint64_t *o, const uint64_t *a, const uint64_t *b, uint64_t size, uint64_t *stack);


/**
 * @brief Caryless multiplication of two words of 64 bits
 *
 * Implemntation of the algorithm mul1 in https://hal.inria.fr/inria-00188261v4/document.
 * With w = 64 and s = 4
 *
 * @param[out] c The result c = a * b
 * @param[in] a The first value a
 * @param[in] b The second value b
 */
void base_mul(uint64_t *c, uint64_t a, uint64_t b) {
   uint64_t h = 0;
   uint64_t l = 0;
   uint64_t g;
   uint64_t u[16] = {0};
   uint64_t mask_tab[4] = {0};
   
   // Step 1
   u[0] = 0;
   u[1] = b & ((1UL << (64 - 4)) - 1UL);
   u[2] = u[1] << 1;
   u[3] = u[2] ^ u[1];
   u[4] = u[2] << 1;
   u[5] = u[4] ^ u[1];
   u[6] = u[3] << 1;
   u[7] = u[6] ^ u[1];
   u[8] = u[4] << 1;
   u[9] = u[8] ^ u[1];
   u[10] = u[5] << 1;
   u[11] = u[10] ^ u[1];
   u[12] = u[6] << 1;
   u[13] = u[12] ^ u[1];
   u[14] = u[7] << 1;
   u[15] = u[14] ^ u[1];
 
   g=0;
   uint64_t tmp1 = a & 15;

   for(int i = 0; i < 16; i++) {
    uint64_t tmp2 = tmp1 - i;
    g ^= (u[i] & -(1 - ((tmp2 | -tmp2) >> 63)));
   }
   l = g;
   h = 0;

   // Step 2
   for (uint8_t i = 4; i < 64; i += 4) {
      g = 0;
      uint64_t tmp1 = (a >> i) & 15;
      for (int j = 0; j < 16; ++j) {
        uint64_t tmp2 = tmp1 - j;
        g ^= (u[j] & -(1 - ((tmp2 | -tmp2) >> 63)));
      }

      l ^= g << i;
      h ^= g >> (64 - i);
   }

   // Step 3
   mask_tab [0] = - ((b >> 60) & 1);
   mask_tab [1] = - ((b >> 61) & 1);
   mask_tab [2] = - ((b >> 62) & 1);
   mask_tab [3] = - ((b >> 63) & 1);

   l ^= ((a << 60) & mask_tab[0]);
   h ^= ((a >> 4) & mask_tab[0]);

   l ^= ((a << 61) & mask_tab[1]);
   h ^= ((a >> 3) & mask_tab[1]);

   l ^= ((a << 62) & mask_tab[2]);
   h ^= ((a >> 2) & mask_tab[2]);

   l ^= ((a << 63) & mask_tab[3]);
   h ^= ((a >> 1) & mask_tab[3]);

   c[0] = l;
   c[1] = h;
}




void karatsuba_add1(uint64_t *alh, uint64_t *blh, const uint64_t *a, const uint64_t *b, uint64_t size_l, uint64_t size_h) {
   for (uint64_t i = 0; i < size_h; i++) {
      alh[i] = a[i] ^ a[i + size_l];
      blh[i] = b[i] ^ b[i + size_l];
   }

   if (size_h < size_l) {
      alh[size_h] = a[size_h];
      blh[size_h] = b[size_h];
   }
}



void karatsuba_add2(uint64_t *o, uint64_t *tmp1, uint64_t* tmp2, uint64_t size_l, uint64_t size_h) {
   for (uint64_t i = 0; i < (2 * size_l) ; i++) {
      tmp1[i] = tmp1[i] ^ o[i];
   }

   for (uint64_t i = 0; i < ( 2 * size_h); i++) {
      tmp1[i] = tmp1[i] ^ tmp2[i];
   }

   for (uint64_t i = 0; i <  (2 * size_l); i++) {
      o[i + size_l] = o[i + size_l] ^ tmp1[i];
   }
}



/**
 * Karatsuba multiplication of a and b, Implementation inspired from the NTL library.
 *
 * \param[out] o Polynomial
 * \param[in] a Polynomial
 * \param[in] b Polynomial
 * \param[in] size Length of polynomial
 * \param[in] stack Length of polynomial
 */
void karatsuba(uint64_t *o, const uint64_t *a, const uint64_t *b, uint64_t size, uint64_t *stack) {
   uint64_t size_l, size_h;
   const uint64_t *ah, *bh;

   if (size == 1) {
      base_mul(o, a[0], b[0]);
      return;
   }

   size_h = size / 2;
   size_l = (size + 1) / 2;

   uint64_t *alh = stack;
   uint64_t *blh = alh + size_l;
   uint64_t *tmp1 = blh + size_l;
   uint64_t *tmp2 = o + 2 * size_l;
   
   stack += 4 * size_l;

   ah = a + size_l;
   bh = b + size_l;

   karatsuba(o, a, b, size_l, stack);

   karatsuba(tmp2, ah, bh, size_h, stack);

   karatsuba_add1(alh, blh, a, b, size_l, size_h);

   karatsuba(tmp1, alh, blh, size_l, stack);

   karatsuba_add2(o, tmp1, tmp2, size_l, size_h);
}

/**
 * @brief Multiply two polynomials modulo \f$ X^n - 1\f$.
 *
 * This functions multiplies a sparse polynomial <b>a1</b> (of Hamming weight equal to <b>weight</b>)
 * and a dense polynomial <b>a2</b>. The multiplication is done modulo \f$ X^n - 1\f$.
 *
 * @param[out] o Pointer to the result
 * @param[in] a1 Pointer to the sparse polynomial
 * @param[in] a2 Pointer to the dense polynomial
 * @param[in] weight Integer that is the weigt of the sparse polynomial
 * @param[in] ctx Pointer to the randomness context
 */
void kar_mul(uint64_t *o, const uint64_t *a1, const uint64_t *a2) {
    uint64_t stack[VEC_N_SIZE_64 << 3] = {0};
    uint64_t o_karat[(VEC_N_SIZE_64 << 1) + 1] = {0};

    karatsuba(o_karat, a1, a2, VEC_N_SIZE_64, stack);
    reduce(o, o_karat);
}

/**
 * @brief swap two elements in a table
 *
 * This function exchanges tab[elt1] with tab[elt2]
 *
 * @param[in] tab Pointer to the table
 * @param[in] elt1 Index of the first element
 * @param[in] elt2 Index of the second element
 */
static inline void swap(uint16_t *tab, uint16_t elt1, uint16_t elt2) {
    uint16_t tmp = tab[elt1];

    tab[elt1] = tab[elt2];
    tab[elt2] = tmp;
}



/**
 * @brief Compute o(x) = a(x) mod \f$ X^n - 1\f$
 *
 * This function computes the modular reduction of the polynomial a(x)
 *
 * @param[in] a Pointer to the polynomial a(x)
 * @param[out] o Pointer to the result
 */
static void reduce(DIGIT *o, const DIGIT *a) {
    size_t i;
    DIGIT r;
    DIGIT carry;

    for (i = 0; i < VEC_N_SIZE_DIGIT; i++) {
        r = a[i + VEC_N_SIZE_DIGIT - 1] >> (PARAM_N &(DIGIT_SIZE_b-1));
        carry = (DIGIT) (a[i + VEC_N_SIZE_DIGIT] << (DIGIT_SIZE_b - (PARAM_N & (DIGIT_SIZE_b-1))));
        o[i] = a[i] ^ r ^ carry;
    }
    o[VEC_N_SIZE_DIGIT - 1] &= BITMASK(PARAM_N, DIGIT_SIZE_b);
}


/**
 * @brief computes product of the polynomial a1(x) with the sparse polynomial a2
 *
 *  o(x) = a1(x)a2(x)
 *
 * @param[out] o Pointer to the result
 * @param[in] a1 Pointer to the sparse polynomial a2 (list of degrees of the monomials which appear in a2)
 * @param[in] a2 Pointer to the polynomial a1(x)
 * @param[in] weight Hamming wifht of the sparse polynomial a2
 * @param[in] ctx Pointer to a seed expander used to randomize the multiplication process
 */
static void fast_convolution_mult(uint64_t *o, const uint32_t *a1, const uint64_t *a2, const uint16_t weight, seedexpander_state *ctx){
    uint64_t carry;
    int32_t dec, s;
    uint64_t table[TABLE * (VEC_N_SIZE_64 + 1)];
    uint16_t permuted_table[TABLE];
    uint16_t permutation_table[TABLE];
    uint16_t permuted_sparse_vect[PARAM_OMEGA_E];
    uint16_t permutation_sparse_vect[PARAM_OMEGA_E];

    for (size_t i = 0; i < TABLE; i++) {
        permuted_table[i] = (uint16_t) i;
    }

    seedexpander(ctx, (uint8_t *) permutation_table, TABLE << 1);

    for (size_t i = 0; i < TABLE - 1; i++) {
        swap(permuted_table + i, 0, permutation_table[i] % (TABLE - i));
    }

    uint64_t *pt = table + (permuted_table[0] * (VEC_N_SIZE_64 + 1));

    for (size_t i = 0 ; i < VEC_N_SIZE_64 ; i++) {
        pt[i] = a2[i];
    }

    pt[VEC_N_SIZE_64] = 0x0UL;

    for (size_t i = 1; i < TABLE; i++) {
        carry = 0x0UL;
        int32_t idx = permuted_table[i] * (VEC_N_SIZE_64 + 1);
        uint64_t *pt = table + idx;

        for (size_t j = 0; j < VEC_N_SIZE_64; j++) {
            pt[j] = (a2[j] << i) ^ carry;
            carry = (a2[j] >> ((WORD - i)));
        }

        pt[VEC_N_SIZE_64] = carry;
    }

    for (size_t i = 0; i < weight; i++) {
        permuted_sparse_vect[i] = (uint16_t) i;
    }

    seedexpander(ctx, (uint8_t *) permutation_sparse_vect, weight << 1);

    for (int32_t i = 0; i < (weight - 1); i++) {
        swap(permuted_sparse_vect + i, 0, permutation_sparse_vect[i] % (weight - i));
    }

    for (size_t i = 0; i < weight; i++) {
        carry = 0x0UL;
        dec = a1[permuted_sparse_vect[i]] & 0xf;
        s = a1[permuted_sparse_vect[i]] >> 4;

        uint16_t *res_16 = (uint16_t *) o;
        res_16 += s;
        uint64_t *pt = table + (permuted_table[dec] * (VEC_N_SIZE_64 + 1));

        for (size_t j = 0; j < VEC_N_SIZE_64 + 1; j++) {
            uint64_t tmp = (uint64_t) res_16[0] | ((uint64_t) (res_16[1])) << 16 |
                           (uint64_t) (res_16[2]) << 32 | ((uint64_t) (res_16[3])) << 48;
            tmp ^= pt[j];
            memcpy(res_16, &tmp, 8);
            res_16 += 4;
        }
    }
}



/**
 * @brief Multiply two polynomials modulo \f$ X^n - 1\f$.
 *
 * This functions multiplies a sparse polynomial <b>a1</b> (of Hamming weight equal to <b>weight</b>)
 * and a dense polynomial <b>a2</b>. The multiplication is done modulo \f$ X^n - 1\f$.
 *
 * @param[out] o Pointer to the result
 * @param[in] a1 Pointer to the sparse polynomial
 * @param[in] a2 Pointer to the dense polynomial
 * @param[in] weight Integer that is the weigt of the sparse polynomial
 * @param[in] ctx Pointer to the randomness context
 */
void vect_mul(uint64_t *o, const uint32_t *a1, const uint64_t *a2, const uint16_t weight, seedexpander_state *ctx) {
    uint64_t tmp[(VEC_N_SIZE_64 << 1) + 1] = {0};

    fast_convolution_mult(tmp, a1, a2, weight, ctx);
    reduce(o, tmp);
}
