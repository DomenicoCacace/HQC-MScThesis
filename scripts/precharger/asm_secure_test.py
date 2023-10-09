#!/usr/bin/python3.10

from asm_secure import Cfg, protected_code, ASMI

# emulation
def hook_mem_invalid(uc, access, address, size, value, user_data):
    eip = uc.reg_read(stack_reg)

    if access == UC_MEM_WRITE:
        print("invalid WRITE of 0x%x at 0x%X, data size = %u, data value = 0x%x" % (address, eip, size, value))
    if access == UC_MEM_READ:
        print("invalid READ of 0x%x at 0x%X, data size = %u" % (address, eip, size))

    return False

def hook_code(uc, address, size, user_data):
    from unicorn.arm_const import UC_ARM_REG_R0, UC_ARM_REG_R1, UC_ARM_REG_R7, UC_ARM_REG_R8
    idx = (address - 0x1000000)//size
    r0 = uc.reg_read(UC_ARM_REG_R0)
    r1 = uc.reg_read(UC_ARM_REG_R1)
    r7 = uc.reg_read(UC_ARM_REG_R7)
    r8 = uc.reg_read(UC_ARM_REG_R8)
    code = uc.mem_read(address, size)
    md = user_data
    asm = ','.join([ str(i) for i in list(md.disasm(code, size)) ])
    print(f"{asm:55} r0={r0:10}, r1={r1:10}, r7={r7:10}, r8={r8:10}")


def test(counter):
  from keystone import Ks, KS_ARCH_ARM, KS_MODE_ARM, KsError
  from unicorn import Uc, UC_ARCH_ARM, UC_MODE_ARM, UcError, UC_HOOK_MEM_INVALID, UC_HOOK_CODE
  from unicorn.arm_const import UC_ARM_REG_R0, UC_ARM_REG_R1, UC_ARM_REG_SP
  from capstone import Cs, CS_ARCH_ARM, CS_MODE_ARM
  
  ARM_CODE = """
  @ n is r0, we will pass it from python, ans is r1
  mov r1, 1       	@ ans = 1
loop:
  cmp r0, 0       	@ while n >= 0:
  mulgt r1, r1, r0	@   ans *= n
  subgt r0, r0, 1 	@   n = n - 1
  bgt loop        	@ 
                	@ answer is in r1
"""
  # Apply countermeasure
  if counter :
    asm = [ASMI(i+'\n') for i in ARM_CODE.split('\n') if i.strip()!='']
    needs_prologue=False
    for i in asm :
      needs_prologue = i.add_protection(needs_prologue)
    ARM_CODE = protected_code(asm)
    print(ARM_CODE)
  # Run test
  try :
    ks = Ks(KS_ARCH_ARM, KS_MODE_ARM)
    ARM_BYTECODE_list, count = ks.asm(ARM_CODE)
    ARM_BYTECODE = bytes(ARM_BYTECODE_list)
    print(f"Number of statements: {count}")
  except KsError as e:
    print(f"Error {e}")
  ADDRESS = 0x1000000
  print("Emulating the ARM code")
  try:
    # Initialize emulator in ARM mode
    mu = Uc(UC_ARCH_ARM, UC_MODE_ARM)
    # map 2MB memory for this emulation
    mu.mem_map(ADDRESS, 2 * 1024 * 1024)
    # write machine code to be emulated to memory
    mu.mem_write(ADDRESS, ARM_BYTECODE)
    # Set the r0 register in the code, let's calculate factorial(5)
    mu.reg_write(UC_ARM_REG_R0, 5)
    mu.reg_write(UC_ARM_REG_SP, 0x1100000) # set sort of arbitrary sp
    # emulate code in infinite time and unlimited instructions
    mu.mem_write(16778216, bytes([12,34,56,78]))

    mu.hook_add(UC_HOOK_MEM_INVALID, hook_mem_invalid)
    md = Cs(CS_ARCH_ARM, CS_MODE_ARM)
    mu.hook_add(UC_HOOK_CODE, hook_code, user_data=md)
    
    mu.emu_start(ADDRESS, ADDRESS + len(ARM_BYTECODE),3000,180)
    # now print out the R0 register
    print("Emulation done. Below is the result")
    # retrieve the result from the R1 register
    r1 = mu.reg_read(UC_ARM_REG_R1)
    print(">>  R1 = %u" % r1)
  except UcError as e:
    print("Unicorn Error: %s" % e) 
    print("SP = %x" %mu.reg_read(UC_ARM_REG_SP))

if __name__ == '__main__' :
    print('Running test')
    cfg = Cfg(reserved_registers=2,rng_address=16778216)
    print('Base')
    test(False)
    print('Counter')
    test(True)

