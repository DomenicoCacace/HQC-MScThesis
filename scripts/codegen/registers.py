class Register:
    def __init__(self, name):
        self.name = name
        self.ref = None
        self.inUse = False
        self.memLoc = None
        self.inSync = True

    def __str__(self):
        return self.name

    def __eq__(self, other):
        return self.name == other.name

class RegisterBank:
    def __init__(self):
        self.regS = []
        self.regR = []
        for s in range(31, -1, -1):
            self.regS.append(Register("s{}".format(s)))
        for r in range(12+1):
            self.regR.append(Register("r{}".format(r)))

    def getRegister(self):
        for r in self.registers:
            if not r.inUse:
                r.inUse = True
                return r

    def getRegisterR(self):
        for r in self.regR:
            if not r.inUse:
                r.inUse = True
                return r
    
    def getRegisterS(self):
        for s in self.regS:
            if not s.inUse:
                s.inUse = True
                return s
    
    def freeRegister(self, reg):
        reg.inUse = False
        reg.ref = None


    def getRegisterByRef(self, val, onlyR=False):
        registers = []
        if not onlyR:
            registers.extend(self.regS)
        registers.extend(self.regR)
        for r in registers:
            if r.ref == val:
                return r
        return None
    
    def getRegisterByAddress(self, addr, onlyR=False):
        registers = []
        if not onlyR:
            registers.extend(self.regS)
        registers.extend(self.regR)        
        for r in registers:
            if r.memLoc == addr and r.inUse:
                return r
        return None

    def availableR(self):
        count = 0
        for r in self.regR:
            if not r.inUse:
                count += 1
        return count

    def availableS(self):
        count = 0
        for r in self.regS:
            if not r.inUse:
                count += 1
        return count

    def __str__(self):
        str = ""
        for r in self.regS:
            str += "{}: {} {} {}\n".format(r.name, r.ref, r.memLoc, r.inUse)
        for r in self.regR:
            str += "{}: {} {} {}\n".format(r.name, r.ref, r.memLoc, r.inUse)
        return str
