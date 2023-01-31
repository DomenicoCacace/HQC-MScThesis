/**
 *
 * Optimized ISO-C11 Implementation of LEDAcrypt using GCC built-ins.
 *
 * @version 3.0 (May 2020)
 *
 * In alphabetical order:
 *
 * @author Marco Baldi <m.baldi@univpm.it>
 * @author Alessandro Barenghi <alessandro.barenghi@polimi.it>
 * @author Franco Chiaraluce <f.chiaraluce@univpm.it>
 * @author Gerardo Pelosi <gerardo.pelosi@polimi.it>
 * @author Paolo Santini <p.santini@pm.univpm.it>
 *
 * This code is hereby placed in the public domain.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHORS ''AS IS'' AND ANY EXPRESS
 * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHORS OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
 * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 **/

#pragma once

/*----------------------------------------------------------------------------*/

#include "architecture_detect.h"
#include <inttypes.h>
#include <limits.h>
#include <stddef.h>
#include "parameters.h"

#define P PARAM_N
#define CONSTANT_TIME

/*----------------------------------------------------------------------------*/
/* limb size definitions for the multi-precision GF(2^x) library              */
/*----------------------------------------------------------------------------*/

#ifdef CORTEX_M4
#define DIGIT_IS_ULONG
#define DIGIT_IS_UINT32
#else
#define DIGIT_IS_ULLONG
#define DIGIT_IS_UINT64
#endif

#define SIGNED_DIGIT int64_t

#define    POSITION_T uint32_t
#define    SIGNED_POSITION_T int32_t
#define    SLACK_SIZE (DIGIT_SIZE_b-(P%DIGIT_SIZE_b))
#define    SLACK_CLEAR_MASK ( ((DIGIT) 0 - 1) >> (DIGIT_SIZE_b-(P%DIGIT_SIZE_b)))
#define    SLACK_EXTRACT(digit_to_extract)  (digit_to_extract >> (P%DIGIT_SIZE_b) )
/*----------------------------------------------------------------------------*/

