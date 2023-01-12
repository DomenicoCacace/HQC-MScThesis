def load(reg, offset):
    return "ldr {}, [r14, #{}]\n".format(reg, offset*4)

def xor(dst, op1, op2):
    return "eor {}, {}, {}\n".format(dst, op1, op2)

def mov(dst, src):
    return "vmov {}, {}\n".format(dst, src)

def storeAll(queue):
    outbounds = []
    code = ""
    for reg in queue:
        name = reg.name
        memLoc = reg.memLoc
        # when storing s registers the maximum offset is +- 1020
        if name[0] == 's' and memLoc*4 > 1020:
            outbounds.append(reg)
        else:
            code += store(reg)

    if len(outbounds) > 0:
        name = reg.name
        memLoc = reg.memLoc
        # find the minimum memLoc ref in outbounds
        offset = min([reg.memLoc for reg in outbounds])
        code += "add r14, r14, #{}\n".format(offset*4)
        for reg in outbounds:
            newreg = Register(reg.name)
            newreg.ref = reg.ref
            newreg.memLoc = reg.memLoc-offset
            code += store(newreg)
        code += "sub r14, r14, #{}\n".format(offset*4)

    return code

def store(reg):
    name = reg.name
    memLoc = reg.memLoc
    if name[0] == "r":
        return "str {}, [r14, #{}]\n".format(name, memLoc*4)
    else:
        if memLoc*4 > 1020:
            code = "add r14, r14, #{}\n".format(memLoc*4)
            code += "vstr.32 {}, [r14]\n".format(name)
            code += "sub r14, r14, #{}\n".format(memLoc*4)
            return code
        else:
            return "vstr.32 {}, [r14, #{}]\n".format(name, memLoc*4)
