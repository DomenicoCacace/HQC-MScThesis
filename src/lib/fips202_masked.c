// This file implementation is taken from https://eprint.iacr.org/2020/733
#include "fips202_masked.h"

#include <string.h>
#define NROUNDS 24

#define ROL(a, offset) ((a << offset) ^ (a >> (64-offset)))
#define MIN(a, b) ((a) < (b) ? (a) : (b))

static void __attribute__ ((noinline)) memxor(void *dest, const void *src, size_t len)
{
  char *d = dest;
  const char *s = src;
  while(len--)
    *d++ ^= *s++;
}

const int keccakf_piln[24] = {
    10, 7,  11, 17, 18, 3, 5,  16, 8,  21, 24, 4,
    15, 23, 19, 13, 12, 2, 20, 14, 22, 9,  6,  1
};

const int keccakf_rotc[24] = {
    1,  3,  6,  10, 15, 21, 28, 36, 45, 55, 2,  14,
    27, 41, 56, 8,  25, 43, 62, 18, 39, 61, 20, 44
};

static void __attribute__ ((noinline)) sha3_theta_rho_pi(uint64_t st[25]) {
    int i, j;
    uint64_t t;
    uint64_t bc[5];

    for (i = 0; i < 5; i++) {
        bc[i] = st[i] ^ st[i + 5] ^ st[i + 10] ^ st[i + 15] ^ st[i + 20];
    }

    for (i = 0; i < 5; i++) {
        t = bc[(i + 4) % 5] ^ ROL(bc[(i + 1) % 5], 1);
        for (j = 0; j < 25; j += 5) {
            st[j + i] ^= t;
        }
    }

    t = st[1];
    for (i = 0; i < 24; i++) {
        j = keccakf_piln[i];
        bc[0] = st[j];
        st[j] = ROL(t, keccakf_rotc[i]);
        t = bc[0];
    }
}

static void __attribute__ ((noinline)) sha3_chi_masked(uint64_t st1[25], uint64_t st2[25], uint64_t bc1[5], uint64_t bc2[5]) {
    for (int j = 0; j < 25; j += 5) {

        memcpy(bc1, st1+j, 5*8);
        memcpy(bc2, st2+j, 5*8);

        for (int i = 0; i < 5; i++) {
            st1[j + i] ^=  ((~bc1[(i + 1) % 5]) & bc1[(i + 2) % 5]);
            st1[j + i] ^=   ((bc1[(i + 1) % 5]) & bc2[(i + 2) % 5]);
            st2[j + i] ^=  ((~bc2[(i + 1) % 5]) & bc2[(i + 2) % 5]);
            st2[j + i] ^=   ((bc2[(i + 1) % 5]) & bc1[(i + 2) % 5]);
        }
    }
}

static void __attribute__ ((noinline)) KeccakF1600_StatePermute_masked(uint64_t st1[25], uint64_t st2[25]) {

    // variables
    int r;
    uint64_t bc1[5], bc2[5];

    // constants
    const uint64_t keccakf_rndc[24] = {
        0x0000000000000001, 0x0000000000008082, 0x800000000000808a,
        0x8000000080008000, 0x000000000000808b, 0x0000000080000001,
        0x8000000080008081, 0x8000000000008009, 0x000000000000008a,
        0x0000000000000088, 0x0000000080008009, 0x000000008000000a,
        0x000000008000808b, 0x800000000000008b, 0x8000000000008089,
        0x8000000000008003, 0x8000000000008002, 0x8000000000000080,
        0x000000000000800a, 0x800000008000000a, 0x8000000080008081,
        0x8000000000008080, 0x0000000080000001, 0x8000000080008008
    };

    // actual iteration
    for (r = 0; r < NROUNDS; r++) {
        // Theta Rho Pi
        // Either ClearStack() or explicitely pass bc1, bc2 for memory-reuse leakage
        sha3_theta_rho_pi(st1);
        // ClearStack();
        sha3_theta_rho_pi(st2);

        //  Chi
        sha3_chi_masked(st1, st2, bc1, bc2);

        //  Iota
        st1[0] ^= keccakf_rndc[r];
    }
}

static void __attribute__ ((noinline)) keccak_absorb_masked(uint64_t *s1,
                          uint64_t *s2,
                          size_t r,
                          const uint8_t *m1,
                          const uint8_t *m2,
                          size_t mlen,
                          unsigned char p)
{

    while (mlen >= r) {
        memxor(s1, m1, r);
        memxor(s2, m2, r);
        KeccakF1600_StatePermute_masked(s1,s2);
        mlen -= r;
        m1 += r;
        m2 += r;

    }

    memxor(s1, m1, mlen);
    // padding
    ((char *) s1)[mlen] ^= p;
    ((char *) s1)[r-1] ^= 128;

    memxor(s2, m2, mlen);
}

static void __attribute__ ((noinline)) keccak_squeezeblocks_masked(unsigned char *h1, unsigned char *h2,
                                size_t nblocks,
                                uint64_t *s1, uint64_t *s2,
                                size_t r) {
    while(nblocks > 0) {
        KeccakF1600_StatePermute_masked(s1,s2);
        // KeccakF1600_StateExtractBytes_sw(s1, h1, 0, r); //asm is different from sw in keccakf1600.c
        // KeccakF1600_StateExtractBytes_sw(s2, h2, 0, r); //asm is different from sw in keccakf1600.c

        memcpy(h1, s1, r);
        memcpy(h2, s2, r);

        h1 += r;
        h2 += r;
        nblocks--;
    }
}

void shake256_masked(uint8_t *output1, uint8_t *output2, size_t outlen, const uint8_t *input1, const uint8_t *input2, size_t inlen) {
      uint8_t t1[SHAKE256_RATE], t2[SHAKE256_RATE], *o1, *o2;
      uint64_t s1[25] = {0}, s2[25] = {0};

      /* Absorb input */
      keccak_absorb_masked(s1, s2, SHAKE256_RATE, input1, input2, inlen, 0x1f);

      /* Squeeze output */
      o1 = output1;
      o2 = output2;
      while (outlen >= SHAKE256_RATE) {
        keccak_squeezeblocks_masked(o1, o2, 1, s1, s2, SHAKE256_RATE);
        o1 += SHAKE256_RATE;
        o2 += SHAKE256_RATE;
        outlen -= SHAKE256_RATE;
      }
      keccak_squeezeblocks_masked(t1, t2, 1, s1, s2, SHAKE256_RATE);
      memcpy(o1, t1, outlen);
      memcpy(o2, t2, outlen);
}

void shake256_init_masked(shake256incctx_masked *state) {
    memset(state->ctx0, 0, 26*8);
    memset(state->ctx1, 0, 26*8);
}

void shake256_absorb_masked(shake256incctx_masked *state, const uint8_t *input1, const uint8_t *input2, size_t inlen) {
    keccak_absorb_masked(state->ctx0, state->ctx1, SHAKE256_RATE, input1, input2, inlen, 0x1f);
}

void shake256_squeeze_masked(uint8_t *output1, uint8_t *output2, size_t outlen, shake256incctx_masked *state) {
    uint8_t t1[SHAKE256_RATE], t2[SHAKE256_RATE], *o1, *o2;
    uint64_t *s1 = state->ctx0;
    uint64_t *s2 = state->ctx1;

    o1 = output1;
    o2 = output2;
    while (outlen >= SHAKE256_RATE) {
        keccak_squeezeblocks_masked(o1, o2, 1, s1, s2, SHAKE256_RATE);
        o1 += SHAKE256_RATE;
        o2 += SHAKE256_RATE;
        outlen -= SHAKE256_RATE;
    }
    keccak_squeezeblocks_masked(t1, t2, 1, s1, s2, SHAKE256_RATE);
    memcpy(o1, t1, outlen);
    memcpy(o2, t2, outlen);
}
