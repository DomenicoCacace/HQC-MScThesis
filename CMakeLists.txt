cmake_minimum_required(VERSION 3.0)

project(HQC)

set(CMAKE_C_FLAGS  "${CMAKE_C_FLAGS} -O3 -std=c99 -pedantic -Wall -Wextra -Wno-unused-function -lm")

set(BASE_DIR ./src)

set(SOURCES ${BASE_DIR}/codes/code.c
			${BASE_DIR}/codes/reed_muller.c
			${BASE_DIR}/codes/reed_solomon.c
			${BASE_DIR}/common/parsing.c
			${BASE_DIR}/common/vector.c
			${BASE_DIR}/fields/fft.c
			${BASE_DIR}/fields/gf.c
			${BASE_DIR}/fields/gf2x.c
			${BASE_DIR}/hqc/hqc.c
			${BASE_DIR}/hqc/kem.c
			${BASE_DIR}/lib/fips202.c
			${BASE_DIR}/lib/shake_ds.c
			${BASE_DIR}/lib/shake_prng.c
			${BASE_DIR}/testing/functional.c
			${BASE_DIR}/testing/plain.c
			${BASE_DIR}/testing/timing.c
			${BASE_DIR}/testing/ttest.c)

set(HEADERS ${BASE_DIR}/codes/code.h
			${BASE_DIR}/codes/reed_muller.h
			${BASE_DIR}/codes/reed_solomon.h
			${BASE_DIR}/common/api.h
			${BASE_DIR}/common/parsing.h
			${BASE_DIR}/common/vector.h
			${BASE_DIR}/fields/fft.h
			${BASE_DIR}/fields/gf.h
			${BASE_DIR}/fields/gf2x.h
			${BASE_DIR}/hqc/hqc.h
			${BASE_DIR}/lib/domains.h
			${BASE_DIR}/lib/fips202.h
			${BASE_DIR}/lib/shake_ds.h
			${BASE_DIR}/lib/shake_prng.h
			${BASE_DIR}/testing/architecture_detect.h
			${BASE_DIR}/testing/timing_tools.h)

include_directories(${BASE_DIR}/codes)
include_directories(${BASE_DIR}/common)
include_directories(${BASE_DIR}/fields)
include_directories(${BASE_DIR}/hqc)
include_directories(${BASE_DIR}/lib)
include_directories(${BASE_DIR}/testing)

add_executable(hqc-${SECURITY_LEVEL} ${HEADERS} ${SOURCES} ${BASE_DIR}/testing/main.c)
set_property(TARGET hqc-${SECURITY_LEVEL} APPEND PROPERTY COMPILE_FLAGS "-DSECURITY_LEVEL=${SECURITY_LEVEL} -DMODE=${MODE} -DALG=${ALG} -DBATCH_SIZE=${BATCH_SIZE}")
target_link_libraries(hqc-${SECURITY_LEVEL} m)
