/**
 * @file gen.c
 * @brief Generate files with parameters to be used in power tests
 */

#include "architecture_detect.h"

#if MODE == GEN

#include "api.h"
#include "hqc.h"
#include "main.h"
#include "parameters.h"


void KEYGEN(void);

void ENC(void);

void DEC(void);

void write_to_file(char *name, uint8_t *data, int len);

void read_from_file(char *name, uint8_t *data, int len);


int run(int reps) {   
    ALG();
    return 0;
}

void KEYGEN(void) {
    unsigned char pk[PUBLIC_KEY_BYTES];
    unsigned char sk[SECRET_KEY_BYTES];

    hqc_pke_keygen(pk, sk);

    write_to_file("pk", (uint8_t *)pk, PUBLIC_KEY_BYTES);
    write_to_file("sk", (uint8_t *)sk, SECRET_KEY_BYTES);
}

void ENC(void) {
    unsigned char pk[PUBLIC_KEY_BYTES];
    DIGIT m[VEC_K_SIZE_DIGIT] = {0};
    DIGIT u[VEC_N_SIZE_DIGIT] = {0};
    DIGIT v[VEC_N1N2_SIZE_DIGIT] = {0};
    unsigned char theta[SHAKE256_512_BYTES] = {0};

    read_from_file("pk", (uint8_t *)pk, PUBLIC_KEY_BYTES);
    read_from_file("m_in", (uint8_t *)m, VEC_K_SIZE_BYTES);
    randombytes(theta, SHAKE256_512_BYTES);

    hqc_pke_encrypt(u, v, m, theta, pk);

    write_to_file("u", (uint8_t *)u, VEC_N_SIZE_BYTES);
    write_to_file("v", (uint8_t *)v, VEC_N1N2_SIZE_BYTES);
}

void DEC(void) {
    unsigned char sk[SECRET_KEY_BYTES];
    DIGIT m[VEC_K_SIZE_DIGIT] = {0};
    DIGIT u[VEC_N_SIZE_DIGIT] = {0};
    DIGIT v[VEC_N1N2_SIZE_DIGIT] = {0};

    read_from_file("sk", (uint8_t *)sk, SECRET_KEY_BYTES);
    read_from_file("u", (uint8_t *)u, VEC_N_SIZE_BYTES);
    read_from_file("v", (uint8_t *)v, VEC_N1N2_SIZE_BYTES);

    hqc_pke_decrypt(m, u, v, sk);

    write_to_file("m_out", (uint8_t *)m, VEC_K_SIZE_BYTES);
}

void write_to_file(char *name, uint8_t *data, int len) {
    FILE *fp;
    uint8_t *p;

    fp = fopen(name, "w");
    p = data;
    for(int i = 0; i < len; i++) {
        fprintf(fp, "%02x ", *p++);
    }
    fprintf(fp, "\n");
    fclose(fp);
}

void read_from_file(char *name, uint8_t *data, int len) {
    FILE *fp;
    uint8_t *p;

    fp = fopen(name, "r");
    p = data;
    for(int i = 0; i < len; i++) {
        fscanf(fp, "%02x ", p++);
    }
    fclose(fp);
}

#endif
