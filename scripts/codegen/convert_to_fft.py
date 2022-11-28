import math

deg_h = [16384, 8192, 4096, 16384, 8192, 2048, 1024, 2048, 512]
deg_l = [ 1024,  512,  256,  4096, 4096,  512,  256, 1024, 256]
PARAM_N = 17669
MAXLEN = PARAM_N//32

def main():
    code = ""
    code += gen_unrolled_asm()
    print(code)


def gen_original():
    code = ""
    for k in range(9):
        DEG_H = deg_h[k]
        DEG_L = deg_l[k]
        j_max = math.ceil(PARAM_N/(DEG_H*2))
        i_max = DEG_H//32 - 4
        src = DEG_H//32
        dst = DEG_L//32
        increment = DEG_H*2//32

        for j in range(j_max, 0, -1):
            for i in range(i_max, -1, -4):
                code += "\tptr = poly;\n"
                code += "\tfor (j = {}; j > 0; j--) {{\n".format(j_max)
                code += "\t\tfor (i = {}; i >= 0; i-=4) {{\n".format(i_max)
                code += "\t\t\tptr[i+{}+0] ^= ptr[i+{}+0];\n".format(dst, src)  
                code += "\t\t\tptr[i+{}+1] ^= ptr[i+{}+1];\n".format(dst, src)
                code += "\t\t\tptr[i+{}+2] ^= ptr[i+{}+2];\n".format(dst, src)
                code += "\t\t\tptr[i+{}+3] ^= ptr[i+{}+3];\n".format(dst, src)
                code += "\t\t}\n"
                code += "\t\tptr += {};\n".format(DEG_H*2//32)
                code += "\t}\n"
                code += "\n"
    
    return code

def gen_unrolled():
    code = ""
    for k in range(9):
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
                    code += "\tptr[{}] ^= ptr[{}];\n".format(dst_idx+0, src_idx+0)
                    code += "\tptr[{}] ^= ptr[{}];\n".format(dst_idx+1, src_idx+1)
                    code += "\tptr[{}] ^= ptr[{}];\n".format(dst_idx+2, src_idx+2)
                    code += "\tptr[{}] ^= ptr[{}];\n".format(dst_idx+3, src_idx+3)
        code += "\n"

    return code

def gen_unrolled_asm():
    code = ""
    code += ".syntax unified\n"
    code += ".cpu cortex-m4\n"
    code += ".fpu fpv4-sp-d16\n"
    code += ".global cvt_to_fft\n"
    code += ".type cvt_to_fft, %function\n"
    code += ".align 2\n"
    code += "\n"
    code += "cvt_to_fft:\n"
    code += "push {r0-r12, r14}\n"
    code += "vpush {d8-d15}\n"
    code += "\n"

    code += "mov r14, r0\n"

    pairs = gen_xors()

    s_count = 31
    r_count = 12
    s_registers = True
    registers = []
    dst_reg = "r0"
    for pair in pairs:

        # check if the source has been modified and not stored in memory
        for r in registers:
            if pair[1] == r[1]:
                code += store(r)

        # s registers available
        if s_count >= 0:
            dst_reg = "r0"
            src_reg = "r1"
            moveTo = "s{}".format(s_count)
            registers.append((moveTo, pair[0]))
            s_count -= 1
            
            code += load(dst_reg, pair[0])
            code += load(src_reg, pair[1])

            code += xor(dst_reg, src_reg)
            code += mov(moveTo, dst_reg)
        else:
            src_reg = "r0"
            dst_reg = "r{}".format(r_count)
            registers.append((dst_reg, pair[0]))
            r_count -= 1

            code += load(dst_reg, pair[0])
            code += load(src_reg, pair[1])
            code += xor(dst_reg, src_reg)

        # time to store
        outbounds = []
        if r_count <= 0:
            for reg in registers:
                # when storing s registers the maximum offset is +- 1020
                if reg[0][0] == 's' and reg[1]*4 > 1020:
                    outbounds.append(reg)
                else:
                    code += store(reg)

            if len(outbounds) > 0:
                offset = min(outbounds, key=lambda x: x[1])[1]
                code += "add r14, r14, #{}\n".format(offset*4)
                for reg in outbounds:
                    newreg = (reg[0], reg[1]-offset)
                    code += store(newreg)
                code += "sub r14, r14, #{}\n".format(offset*4)

            registers = []
            r_count = 12
            s_count = 31
    
    outbounds = []
    for reg in registers:
        # when storing s registers the maximum offset is +- 1020
        if reg[0][0] == 's' and reg[1]*4 > 1020:
            outbounds.append(reg)
        else:
            code += store(reg)

    if len(outbounds) > 0:
            offset = min(outbounds, key=lambda x: x[1])[1]
            code += "add r14, r14, #{}\n".format(offset*4)
            for reg in outbounds:
                newreg = (reg[0], reg[1]-offset)
                code += store(newreg)
            code += "sub r14, r14, #{}\n".format(offset*4)

    code += "vpop {d8-d15}\n"
    code += "pop {r0-r12, r14}\n"
    code += "bx lr\n"
    code += ".size cvt_to_fft, .-cvt_to_fft\n"
    return code

def gen_xors():
    pairs = [] # (dst, src) == dst ^= src
    for k in range(9):
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
                    pairs.append((dst_idx, src_idx))
                src_idx += 1
                dst_idx += 1
                if src_idx <= MAXLEN and dst_idx <= MAXLEN:
                    pairs.append((dst_idx, src_idx))
                src_idx += 1
                dst_idx += 1
                if src_idx <= MAXLEN and dst_idx <= MAXLEN:
                    pairs.append((dst_idx, src_idx))
                src_idx += 1
                dst_idx += 1
                if src_idx <= MAXLEN and dst_idx <= MAXLEN:
                    pairs.append((dst_idx, src_idx))

    return pairs

def store(reg):
    if reg[0][0] == "r":
        return "str {}, [r14, #{}]\n".format(reg[0], reg[1]*4)
    else:
        if reg[1]*4 > 1020:
            code = "add r14, r14, #{}\n".format(reg[1]*4)
            code += "vstr.32 {}, [r14]\n".format(reg[0])
            code += "sub r14, r14, #{}\n".format(reg[1]*4)
            return code
        else:
            return "vstr.32 {}, [r14, #{}]\n".format(reg[0], reg[1]*4)

def load(reg, offset):
    return "ldr {}, [r14, #{}]\n".format(reg, offset*4)

def xor(dst, src):
    return "eor {}, {}, {}\n".format(dst, dst, src)

def mov(dst, src):
    return "vmov {}, {}\n".format(dst, src)


if __name__ == "__main__":
    main()
