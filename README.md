# HQC-MScThesis

## Introduction
This repository contains the implementation of a masking scheme for HQC, a third round alternative candidate for the NIST Post-Quantum Cryptography standardization process.

## Build and run
The project, although was thought for ARM microprocessors, can be also compiled for x86 processors.
When building, it is possible to select various options to customize the executable, such as:
- the security level of HQC (due to memory restrictions the ARM version can only run at 128 bits)
- the verbosity level of the program
- the mode of operation of the program 
- the algorithm to run

Not all algorithms can be run in all modes of operation. The following table shows the possible combinations:

| Algorithm | Functional | Timing | Plain |
|-----------|------------|--------|-------|
| FULL_PKE  | ✔          | ✔      | ✔     |
| FULL_KEM  | ✔          | ✔      | ✔     |
| MULT      | ✔          | ✔      | ✔     |
| ENCRYPT   | ✘          | ✔      | ✔     |
| DECRYPT   | ✘          | ✔      | ✔     |
| ENCAPS    | ✘          | ✔      | ✔     |
| DECAPS    | ✘          | ✔      | ✔     |
| KEYGEN    | ✘          | ✔      | ✔     |


### ARM
To build the project for ARM we use [PlatformIO](https://platformio.org/) as build system and [libopenCM3](https://libopencm3.github.io/) as the library for the microcontroller. The project is tailored for the STM32L476RG board, but it can be easily adapted to run other boards.

When building/uploading the project, a menu will allow to select the USART communication port, the verbosity level, the mode of operation and the algorithm to run.

### CMake
To build the project for x86 we use [CMake](https://cmake.org/) as build system. 

To customize the executable, the following options can be set:
- `SECURITY_LEVEL`: the security level of HQC (128, 192 or 256)
- `VERBOSE`: the verbosity level of the program (0, 1 or 2)
- `MODE`: the mode of operation of the program (0 for `FUNCTIONAL`, 1 for `TIMING`, 2 for `PLAIN`)
- `ALG`: the algorithm to run (`FULL_PKE`, `FULL_KEM`, `MULT`,`ENCRYPT`, `DECRYPT`, `ENCAPS`, `DECAPS`, `KEYGEN`)
