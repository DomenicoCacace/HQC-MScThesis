import math
from codegen import *

def main():
    fname = "cvt_to_fft"
    code = ""
    code += ".syntax unified\n"
    code += ".cpu cortex-m4\n"
    code += ".fpu fpv4-sp-d16\n"
    code += ".global {}\n".format(fname)
    code += ".type {}, %function\n".format(fname)
    code += ".align 2\n"
    code += "\n"
    code += "{}:\n".format(fname)
    code += "push {r0-r12, r14}\n"
    code += "vpush {d8-d15}\n"
    code += "\n"

    code += "mov r14, r0\n"

    code += gen_code()

    code += "vpop {d8-d15}\n"
    code += "pop {r0-r12, r14}\n"
    code += "bx lr\n"
    code += ".size {}, .-{}\n".format(fname, fname)

    print(code)



def gen_code():
    code = ""
    deg_h = [16384, 8192, 4096, 16384, 8192, 2048, 1024, 2048, 512]
    deg_l = [ 1024,  512,  256,  4096, 4096,  512,  256, 1024, 256]
    PARAM_N = 17669
    MAXLEN = PARAM_N//32

    ops = []
    for k in range(len(deg_h)):
        DEG_H = deg_h[k]
        DEG_L = deg_l[k]
        j_max = math.ceil(PARAM_N/(DEG_H*2))
        i_max = DEG_H//32 - 4
        src = DEG_H//32
        dst = DEG_L//32
        increment = DEG_H*2//32

        for j in range(j_max, 0, -1):
            for i in range(i_max, -1, -4):
                dst_idx = i+dst+(j_max-j)*increment
                src_idx = i+src+(j_max-j)*increment
                if src_idx <= MAXLEN and dst_idx <= MAXLEN:
                    code += load("r0", src_idx)
                    code += load("r1", src_idx+1)
                    code += load("r2", src_idx+2)
                    code += load("r3", src_idx+3)
                    code += load("r4", dst_idx)
                    code += load("r5", dst_idx+1)
                    code += load("r6", dst_idx+2)
                    code += load("r7", dst_idx+3)
                    code += xor("r4", "r0", "r4")
                    code += xor("r5", "r1", "r5")
                    code += xor("r6", "r2", "r6")
                    code += xor("r7", "r3", "r7")
                    code += store_plain("r4", dst_idx)
                    code += store_plain("r5", dst_idx+1)
                    code += store_plain("r6", dst_idx+2)
                    code += store_plain("r7", dst_idx+3)

    return code





if __name__ == "__main__":
    main()
