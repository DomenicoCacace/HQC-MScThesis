import math
from codegen import *


def main():
    fname = "irepr_s8"
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
    # use r12 as a pointer to the "upper half" of the input
    # because load and store can access between -255 and +4095
    code += "add r12, r14, #4096\n" 

    code += gen_code()

    code += "vpop {d8-d15}\n"
    code += "pop {r0-r12, r14}\n"
    code += "bx lr\n"
    code += ".size {}, .-{}\n".format(fname, fname)

    print(code)


def gen_code():
    code = ""
    deg_h = []
    deg_l = []
    for i in range(0, 8):
        deg_l.append(2**i)
        deg_h.append(256*(2**i))
    PARAM_N = 17669*2
    MAXLEN = PARAM_N//32

    for k in range(0, 5):
        DEG_H = deg_h[k]
        DEG_L = deg_l[k]
        j_max = math.ceil(65536/(DEG_H*2))
        i_max = DEG_H//32
        src = DEG_H//32
        dst = DEG_L//32
        increment = DEG_H*2//32

        for j in range(j_max, 0, -1):
            code += xor("r0", "r0", "r0")   # leftover = 0
            for i in range(0, i_max, 4):
                dst_idx = i+(j_max-j)*increment + 3
                src_idx = i+src+(j_max-j)*increment + 3

                if dst_idx-3 <= MAXLEN:
                    code += load_adjusted("r1", src_idx)     # p3
                    code += load_adjusted("r2", src_idx-1)   # p2
                    code += load_adjusted("r3", src_idx-2)   # p1
                    code += load_adjusted("r4", src_idx-3)   # p0
                    code += load_adjusted("r5", dst_idx)     # q3
                    code += load_adjusted("r6", dst_idx-1)   # q2
                    code += load_adjusted("r7", dst_idx-2)   # q1
                    code += load_adjusted("r8", dst_idx-3)   # q0

                    code += lshift("r9", "r1", DEG_L)  # p3 << 16
                    code += rshift("r10", "r2", 32-DEG_L)  # p2 >> 16
                    code += xor("r11", "r9", "r10")   # (p3 << 16) ^ (p2 >> 16)
                    code += xor("r5", "r5", "r11")   # q3 ^ ((p3 << 16) ^ (p2 >> 16))

                    code += lshift("r9", "r2", DEG_L)  # p2 << 16
                    code += rshift("r10", "r3", 32-DEG_L)  # p1 >> 16
                    code += xor("r11", "r9", "r10")   # (p2 << 16) ^ (p1 >> 16)
                    code += xor("r6", "r6", "r11")   # q2 ^ ((p2 << 16) ^ (p1 >> 16))

                    code += lshift("r9", "r3", DEG_L)  # p1 << 16
                    code += rshift("r10", "r4", 32-DEG_L)  # p0 >> 16
                    code += xor("r11", "r9", "r10")   # (p1 << 16) ^ (p0 >> 16)
                    code += xor("r7", "r7", "r11")   # q1 ^ ((p1 << 16) ^ (p0 >> 16))

                    code += lshift("r9", "r4", DEG_L)  # p0 << 16
                    code += rshift("r10", "r0", 32-DEG_L)  # leftover >> 16
                    code += xor("r11", "r9", "r10")   # (p0 << 16) ^ (leftover >> 16)
                    code += xor("r8", "r8", "r11")   # q0 ^ ((p0 << 16) ^ (leftover >> 16))

                    code += store_adjusted("r5", dst_idx)
                    code += store_adjusted("r6", dst_idx-1)
                    code += store_adjusted("r7", dst_idx-2)
                    code += store_adjusted("r8", dst_idx-3)

                    code += mov("r0", "r1")         # leftover = p3

            code += rshift("r0", "r0", 32-DEG_L)  # leftover >> 16
            code += load_adjusted("r1", (j_max-j)*increment + i_max)     # ptr[i_max]
            code += xor("r1", "r1", "r0")   # ptr[i_max] ^ (leftover >> 16)
            code += store_adjusted("r1", (j_max-j)*increment + i_max)

    for k in range(5, len(deg_h)):
        DEG_H = deg_h[k]
        DEG_L = deg_l[k]
        j_max = math.ceil(65536/(DEG_H*2))
        i_max = DEG_H//32
        src = DEG_H//32
        dst = DEG_L//32
        increment = DEG_H*2//32

        for j in range(j_max, 0, -1):
            for i in range(0, i_max, +4):
                for _ in range(4):
                    dst_idx = i+dst+(j_max-j)*increment + _
                    src_idx = i+src+(j_max-j)*increment + _
                    if dst_idx <= MAXLEN:
                        code += load_adjusted("r0", src_idx)
                        code += load_adjusted("r1", dst_idx)
                        code += xor("r0", "r0", "r1")
                        code += store_adjusted("r0", dst_idx)
                    else:
                        break

    return code

def load_adjusted(reg, idx):
    addr = idx*4
    if addr >= 0 and addr < 4096:
        return "ldr {}, [r14, #{}]\n".format(reg, addr)
    elif addr >= 4096 and addr < 8192:
        return "ldr {}, [r12, #{}]\n".format(reg, addr-4096)
    else:
        raise Exception("Invalid address: {}".format(addr))

def store_adjusted(reg, idx):
    addr = idx*4
    if addr >= 0 and addr < 4096:
        return "str {}, [r14, #{}]\n".format(reg, addr)
    elif addr >= 4096 and addr < 8192:
        return "str {}, [r12, #{}]\n".format(reg, addr-4096)
    else:
        raise Exception("Invalid address: {}".format(addr))

if __name__ == "__main__":
    main()
