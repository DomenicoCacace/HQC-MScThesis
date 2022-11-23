cmake_minimum_required(VERSION 3.0)

project(HQC)

set(CMAKE_C_FLAGS  "${CMAKE_C_FLAGS} -O3 -std=c99 -funroll-all-loops -flto -pedantic -Wall -Wextra")
set(CMAKE_C_FLAGS_RNG "${CMAKE_C_FLAGS} -Wno-unused-but-set-variable -Wno-unused-parameter -Wno-sign-compare")
set(SECLVL 128)

set(BASE_DIR ./src)

set(SOURCES ${BASE_DIR}/codes/code.c
			${BASE_DIR}/codes/reed_muller.c
			${BASE_DIR}/codes/reed_solomon.c
			${BASE_DIR}/common/parsing.c
			${BASE_DIR}/common/vector.c
			${BASE_DIR}/fastmul/bc_2.c
			${BASE_DIR}/fastmul/bmul2.c
			${BASE_DIR}/fastmul/btfy_consts_gft.c
		    ${BASE_DIR}/fastmul/btfy_ffft.c
			${BASE_DIR}/fastmul/encode.c
			${BASE_DIR}/fastmul/gft_mul_vi.c
			${BASE_DIR}/fields/fft.c
			${BASE_DIR}/fields/gf.c
			${BASE_DIR}/fields/gf2x.c
			${BASE_DIR}/hqc/hqc.c
			${BASE_DIR}/hqc/kem.c
			${BASE_DIR}/lib/fips202.c
			${BASE_DIR}/lib/shake_ds.c
			${BASE_DIR}/lib/shake_prng.c)

set(HEADERS ${BASE_DIR}/codes/code.h
			${BASE_DIR}/codes/reed_muller.h
			${BASE_DIR}/codes/reed_solomon.h
			${BASE_DIR}/common/api.h
			${BASE_DIR}/common/parsing.h
			${BASE_DIR}/common/vector.h
			${BASE_DIR}/fastmul/bc_2.h
			${BASE_DIR}/fastmul/bmul2.h
			${BASE_DIR}/fastmul/btfy_consts_gft.h
			${BASE_DIR}/fastmul/btfy_ffft.h
			${BASE_DIR}/fastmul/encode.h
			${BASE_DIR}/fastmul/gft_mul_vi.h
			${BASE_DIR}/fields/fft.h
			${BASE_DIR}/fields/gf.h
			${BASE_DIR}/fields/gf2x.h
			${BASE_DIR}/hqc/hqc.h
			${BASE_DIR}/lib/domains.h
			${BASE_DIR}/lib/fips202.h
			${BASE_DIR}/lib/shake_ds.h
			${BASE_DIR}/lib/shake_prng.h)

add_executable(hqc-${SECLVL} ${HEADERS} ${SOURCES} ${BASE_DIR}/testing/main_x86.c)
set_property(TARGET hqc-${SECLVL} APPEND PROPERTY COMPILE_FLAGS "-DSECURITY_LEVEL=${SECLVL} -DVERBOSE=1")
