from asm_translator import *
from registers import RegisterBank

def gen_unrolled_asm(fname, ops):
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

    code += gen_code(ops)

    code += "vpop {d8-d15}\n"
    code += "pop {r0-r12, r14}\n"
    code += "bx lr\n"
    code += ".size {}, .-{}\n".format(fname, fname)
    return code


def gen_code(ops):
    code = ""
    reg = RegisterBank()
    storeQueue = []

    for op in ops:
        if isinstance(op, Load):
            dst = reg.getRegisterByAddress(op.src_offset, onlyR=False)
            # not in the register bank, load from memory
            if dst is None:# or dst.name[0] == 's':
                dst = reg.getRegisterR()
                dst.memLoc = op.src_offset
                dst.ref = op.ref
                code += load(dst, op.src_offset)

            # in the R registers, can be used as is
            elif dst.name[0] == 'r':
                dst.ref = op.ref
                
            # in the S registers, must be moved to a R register to be used
            else:
                newDst = reg.getRegisterR()
                newDst.memLoc = dst.memLoc
                newDst.ref = op.ref
                code += mov(newDst, dst)
        elif isinstance(op, Zero):
            dst = reg.getRegisterR()
            dst.ref = op.ref
            code += mov(dst, "#0")
            reg.setZero(dst)
        elif isinstance(op, Discard):
            toFree = reg.getRegisterByRef(op.src_reg)
            reg.freeRegister(toFree)
        elif isinstance(op, Store):
            # find out how many registers are needed to perform
            # the operations up to the next store
            
            """
            requiredRegs = 0
            for op2 in ops[ops.index(op)+1:]:
                if isinstance(op2, Load):
                    requiredRegs += 1
                elif isinstance(op2, Store):
                    break
                else:
                    requiredRegs += 1
            """
            toStore = reg.getRegisterByRef(op.src_reg, onlyR=False)
            
            code += store(toStore)
            reg.freeRegister(toStore)
            """
            # last operation, store regardless of the conditions
            if op == ops[-1]:
                toStore.memLoc = op.dest_offset
                storeQueue.append(toStore)
                code += storeAll(storeQueue)
                for r in storeQueue:
                    reg.freeRegister(r)

            # S registers available, delay the store
            elif reg.availableS() > 0:
                dst = reg.getRegisterS()
                dst.memLoc = op.dest_offset
                dst.ref = op.ref
                code += mov(dst, toStore)
                storeQueue.append(dst)
                reg.freeRegister(toStore)

            # no S registers available but _enough_ R registers, delay the store
            elif reg.availableR() >= 2:
                toStore.memLoc = op.dest_offset
                storeQueue.append(toStore)

            # no S registers available and not enough R registers, store immediately
            else:
                toStore.memLoc = op.dest_offset
                storeQueue.append(toStore)
                code += storeAll(storeQueue)
                for r in storeQueue:
                    reg.freeRegister(r)
                storeQueue = []
            """
            

        elif isinstance(op, Xor):
            dst = reg.getRegisterByRef(op.op1, onlyR=True)
            src = reg.getRegisterByRef(op.op2, onlyR=True)
            code += xor(dst, dst, src)
            dst.ref = op.ref
            #reg.freeRegister(src)
        elif isinstance(op, LShift):
            if isinstance(op.op1, Zero):
                reg.Zero.ref = op.ref
            else:
                dst = reg.getRegisterByRef(op.op1, onlyR=True)
                code += lshift(dst, dst, op.amount)
                dst.ref = op.ref
        elif isinstance(op, RShift):
            if isinstance(op.op1, Zero):
                reg.Zero.ref = op.ref
            else:
                dst = reg.getRegisterByRef(op.op1, onlyR=True)
                if dst is None:
                    IPython.embed()
                code += rshift(dst, dst, op.amount)
                dst.ref = op.ref
            
    
    return code


class Instr:
    idx = 0
    def __init__(self):
        self.ref = Instr.idx
        Instr.idx +=1

class Zero(Instr):
    def __init__(self):
        super().__init__()

    def __str__(self):
        return "ZERO: %{}".format(self.ref)

class Load(Instr):
    def __init__(self, src_offset):
        super().__init__()
        self.src_offset = src_offset
    
    def __str__(self):
        return "LOAD: %{} <- [#{}]".format(self.ref, self.src_offset)

class Store(Instr):
    def __init__(self, dest_offset, src_reg):
        super().__init__()
        self.dest_offset = dest_offset
        self.src_reg = src_reg
    
    def __str__(self):
        return "STORE: %{} -> [#{}]".format(self.src_reg, self.dest_offset)

class Discard(Instr):
    def __init__(self, src_reg):
        super().__init__()
        self.src_reg = src_reg
    
    def __str__(self):
        return "DISCARD: %{} -> [#{}]".format(self.src_reg, self.dest_offset)


class Xor(Instr):
    def __init__(self, op1, op2):
        super().__init__()
        self.op1 = op1
        self.op2 = op2

    def __str__(self):
        return "XOR: %{} <- %{} ^ %{}".format(self.ref, self.op1, self.op2)

class LShift(Instr):
    def __init__(self, op1, amount):
        super().__init__()
        self.op1 = op1
        self.amount = amount

    def __str__(self):
        return "LSH: %{} <- %{} << {}".format(self.ref, self.op1, self.amount)

class RShift(Instr):
    def __init__(self, op1, amount):
        super().__init__()
        self.op1 = op1
        self.amount = amount

    def __str__(self):
        return "RSH: %{} <- %{} >> {}".format(self.ref, self.op1, self.amount)

