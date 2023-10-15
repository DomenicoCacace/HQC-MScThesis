cmake_minimum_required(VERSION 3.5)

project(HQC)

#include(precharge.cmake)
set(PROJECT_NAME "hqc-${SECURITY_LEVEL}")
set(CMAKE_C_FLAGS  "${CMAKE_C_FLAGS} -O3 -std=c99 -pedantic -Wall -Wextra -Wno-unused-function -lm")
set(PROJECT_COMPILE_FLAGS "-DSECURITY_LEVEL=${SECURITY_LEVEL} -DMODE=${MODE} -DALG=${ALG} -DBATCH_SIZE=${BATCH_SIZE} -DMASK_ENABLE")
set(BASE_DIR ${CMAKE_SOURCE_DIR}/src)

include_directories(${BASE_DIR}/codes)
include_directories(${BASE_DIR}/common)
include_directories(${BASE_DIR}/fastmul)
include_directories(${BASE_DIR}/fields)
include_directories(${BASE_DIR}/hqc)
include_directories(${BASE_DIR}/lib)
include_directories(${BASE_DIR}/testing)

#################################################
# C SOURCE FILES								#
#################################################
list(APPEND SOURCES_CODES
	${BASE_DIR}/codes/code.c
	${BASE_DIR}/codes/reed_muller.c
	${BASE_DIR}/codes/reed_solomon.c
)
list(APPEND SOURCES_COMMON
	${BASE_DIR}/common/parsing.c
	${BASE_DIR}/common/vector.c
)
list(APPEND SOURCES_FASTMUL
	${BASE_DIR}/fastmul/bc_2.c
	${BASE_DIR}/fastmul/bmul2.c
	${BASE_DIR}/fastmul/btfy_consts_gft.c
	${BASE_DIR}/fastmul/btfy_ffft.c
	${BASE_DIR}/fastmul/encode.c
	${BASE_DIR}/fastmul/gft_mul_vi.c
)
list(APPEND SOURCES_FIELDS
	${BASE_DIR}/fields/fft.c
	${BASE_DIR}/fields/gf.c
	${BASE_DIR}/fields/gf2x.c
)
list(APPEND SOURCES_HQC
	${BASE_DIR}/hqc/hqc.c
	${BASE_DIR}/hqc/kem.c
)
list(APPEND SOURCES_LIB
	${BASE_DIR}/lib/fips202.c
	${BASE_DIR}/lib/fips202_masked.c
	${BASE_DIR}/lib/shake_ds.c
	${BASE_DIR}/lib/shake_prng.c
)
list(APPEND SOURCES_TESTING
	${BASE_DIR}/testing/functional.c
	${BASE_DIR}/testing/gen.c
	${BASE_DIR}/testing/plain.c
	${BASE_DIR}/testing/timing.c
	${BASE_DIR}/testing/ttest.c
)

#################################################
# C SOURCES TO PRECHARGE						#
#################################################
list(APPEND SOURCES_TOPRECHARGE

)

#################################################
# C HEADER FILES								#
#################################################
list(APPEND HEADERS_CODES
	${BASE_DIR}/codes/code.h
	${BASE_DIR}/codes/reed_muller.h
	${BASE_DIR}/codes/reed_solomon.h
)
list(APPEND HEADERS_COMMON
	${BASE_DIR}/common/api.h
	${BASE_DIR}/common/parsing.h
	${BASE_DIR}/common/vector.h
)
list(APPEND HEADERS_FASTMUL
	${BASE_DIR}/fastmul/bc_2.h
	${BASE_DIR}/fastmul/bmul2.h
	${BASE_DIR}/fastmul/btfy_consts_gft.h
	${BASE_DIR}/fastmul/btfy_ffft.h
	${BASE_DIR}/fastmul/encode.h
	${BASE_DIR}/fastmul/gft_mul_vi.h
)
list(APPEND HEADERS_FIELDS
	${BASE_DIR}/fields/fft.h
	${BASE_DIR}/fields/gf.h
	${BASE_DIR}/fields/gf2x.h
	${BASE_DIR}/fields/shares.h
)
list(APPEND HEADERS_HQC
	${BASE_DIR}/hqc/hqc.h
)
list(APPEND HEADERS_LIB
	${BASE_DIR}/lib/domains.h
	${BASE_DIR}/lib/fips202.h
	${BASE_DIR}/lib/fips202_masked.h
	${BASE_DIR}/lib/shake_ds.h
	${BASE_DIR}/lib/shake_prng.h
)
list(APPEND HEADERS_TESTING
	${BASE_DIR}/testing/architecture_detect.h
	${BASE_DIR}/testing/timing_tools.h
)

#################################################
# RUN PRECHARGING								#
#################################################

#set(PRECHARGING_SCRIPT "${CMAKE_SOURCE_DIR}/scripts/precharger/asm_secure.py")
#list(APPEND INCLUDE_DIRS 
#	"-I${BASE_DIR}/codes"
#	"-I${BASE_DIR}/common"
#	"-I${BASE_DIR}/fastmul"
#	"-I${BASE_DIR}/fields"
#	"-I${BASE_DIR}/hqc"
#	"-I${BASE_DIR}/lib"
#	"-I${BASE_DIR}/testing"
#)
#
#foreach(FILE IN LISTS SOURCES_TOPRECHARGE)
#	get_filename_component(FILENAME ${FILE} NAME_WE)
#   set(COMMON_DIR "${BASE_DIR}/common")
#	set(ASM_OUTPUT "${CMAKE_SOURCE_DIR}/build/${FILENAME}.s")
#	precharge_source("${FILE}" "${ASM_OUTPUT}" "${PRECHARGING_SCRIPT}" "${CMAKE_C_FLAGS} ${PROJECT_COMPILE_FLAGS}" ${INCLUDE_DIRS})
#	list(APPEND PRECHARGED_SOURCES ${ASM_OUTPUT})
#endforeach()


list(APPEND SOURCES 
	${SOURCES_CODES}
	${SOURCES_COMMON}
	${SOURCES_FASTMUL}
	${SOURCES_FIELDS}
	${SOURCES_HQC}
	${SOURCES_LIB}
	${SOURCES_TESTING}
)

list(APPEND HEADERS 
	${HEADERS_CODES}
	${HEADERS_COMMON}
	${HEADERS_FASTMUL}
	${HEADERS_FIELDS}
	${HEADERS_HQC}
	${HEADERS_LIB}
	${HEADERS_TESTING}
)

add_executable(${PROJECT_NAME} ${HEADERS} ${SOURCES} ${BASE_DIR}/testing/main.c)
set_property(TARGET ${PROJECT_NAME} APPEND PROPERTY COMPILE_FLAGS ${PROJECT_COMPILE_FLAGS})
target_link_libraries(${PROJECT_NAME} m)
