import math
from codegen import *

def main():
    code = ""
    ops = gen_ops()
    code += gen_unrolled_asm("cvt_to_fft", ops)
    print(code)


def gen_ops():
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
                for _ in range(4):
                    dst_idx = i+dst+(j_max-j)*increment + _
                    src_idx = i+src+(j_max-j)*increment + _
                    if src_idx <= MAXLEN and dst_idx <= MAXLEN:
                        l1 = Load(src_idx)
                        l2 = Load(dst_idx)
                        x = Xor(l2.ref, l1.ref)
                        s = Store(dst_idx, x.ref)
                        ops.extend([l2, l1, x, s])
                    else:
                        break

    return ops





if __name__ == "__main__":
    main()
