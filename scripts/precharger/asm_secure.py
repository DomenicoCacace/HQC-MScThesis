#!/usr/bin/python3.10
from dataclasses import dataclass, field
import sys

__doc__ = '''
Compilation
  arm-linux-gnueabi-gcc -S -I../common gf.c -DSECURITY_LEVEL=128
  asm_secure.py gf.s
  arm-linux-gnueabi-gcc -c gf.s

assumption: r8 and r7 are not used in the code
r6reserved = False # in config, set to true if also register r6 is reserved

to ensure this add in each compilation unit:
  register int *random  asm ("r8");
  register int *rngaddr asm ("r7");
  register int *apsrpro asm ("r6");

'''

# ARM code manipulation functions
registers = [ 'r'+str(i) for i in range(16) ]
special_registers = [ 'a1', 'a2', 'a3', 'a4', 'v1', 'v2', 'v3', 'v4', 'v5', 'sb', 'sl', 'fp', 'ip', 'sp', 'lr', 'pc' ]

def find_register(string):
  res = [ r for r in registers + special_registers if string.find(r)!=-1 ]
  if len(res) > 1 : raise Exception(f'Too many registers in string: {string}')
  if len(res) ==0 : raise Exception(f'No registers in string: {string}')
  return res[0]

def neg_cond(cond):
  if cond == 'eq' : return 'ne'
  if cond == 'ne' : return 'eq'
  if cond == 'ge' : return 'lt'
  if cond == 'lt' : return 'ge'
  if cond == 'le' : return 'gt'
  if cond == 'gt' : return 'le'
  raise Exception('Unmanaged condition type')

# Configuration 
class Cfg(object):
  '''Needs to know how many reserved registers there are, as well as where is the TRNG'''
  def autodetect(self,reserved_registers):
    try : 
      self.reserved_registers = int(reserved_registers)
      return
    except ValueError : pass
    # autodetection
    s1='register int *random  asm ("r8");'
    s2='register int *rngaddr asm ("r7");'
    s3='register int *apsrpro asm ("r6");'
    r=0
    fn = reserved_registers.split('.')[0]+'.c'
    try :
      with open(fn) as fin :
        r = len([ l for l in fin.readlines() if s1 in l or s2 in l or s3 in l ])
      print(f'{fn} autodetected: {r}', file=sys.stderr)
    except Exception : 
      print(f"Autodetect failed on {fn}!", file=sys.stderr)
    self.reserved_registers=r
    
  def __init__(self, reserved_registers=2, rng_address=None):
    if not rng_address : 
      # definition of RNG data address according to the STM32nucleo board needs
      per_base = 0x42000000
      apb_base = 0x08000000
      rng_base = 0x08060800
      rng_data = 0x08
      rng_address = per_base + apb_base + rng_base + rng_data
    self.rng_address=rng_address # for future needs
    self.load_random_and_add_to_itself = ''
    self.store_random_value = ''
    self.prologue = ''
    self.precharge_war_case = ''
    self.save_psr = ''
    self.load_psr = ''
    self.autodetect(reserved_registers)
    if self.reserved_registers==3 : # use r8, r7, and r6
      self.load_random_and_add_to_itself = '''
\tldr{0} r8, [r7]     @ load from TRNG
\tadd {1}, r8, r8     @ sum with itself 
'''
      self.store_random_value = '''
\tldr{0} r8, [r7]     @ load from TRNG
\tstr{0} r8, {1}      @ store over address 
'''
      self.prologue = '''
\tldr r7, ={}         @ set the address
'''.format(rng_address)
      self.precharge_war_case = '''
\tldr{0} r8, [r7]       @ load from TRNG
\tstr{0} r8, [sp, #-4]  @ protect next store
\tstr{0} {1}, [sp, #-4] @ store accumulator
\tldr{0} r8, [r7]       @ load from TRNG
\tadd {1}, r8, r8       @ protect accumulator
\tldr{0} r8, [sp, #-4]  @ restore accumulator value
''' # add rX r8 rY 
      self.save_psr = '''
\tldr r6, [r7]       @ load from TRNG
\tmrs r6, apsr 
\tstr r6, [sp, #-8]
''' # see fix below
      self.load_psr = '''
\tldr r6, [r7]       @ load from TRNG
\tldr r6, [sp, #-8]
\tmsr apsr, r6
'''
    elif self.reserved_registers==2 : # use r8 and r7 only
      self.load_random_and_add_to_itself = '''
\tldr r8, ={}         @ load TRNG address
\tldr{{0}} r8, [r8]   @ load from TRNG
\tadd {{1}}, r8, r8   @ sum with itself 
'''.format(rng_address)
      self.store_random_value = '''
\tldr r8, ={}         @ load TRNG address
\tldr{{0}} r8, [r8]   @ load from TRNG
\tstr{{0}} r8, {{1}}  @ store over address 
'''.format(rng_address)
      self.prologue = '''
'''
      self.precharge_war_case = '''
\tldr r8, ={0}           @ load TRNG address
\tldr{{0}} r8, [r8]      @ load from TRNG
\tstr{{0}} r8, [sp, #-4]     @ protect next store
\tstr{{0}} {{1}}, [sp, #-4]  @ store accumulator
\tldr r8, ={0}           @ load TRNG address
\tldr{{0}} r8, [r8]      @ load from TRNG
\tadd {{1}}, r8, r8      @ protect accumulator
\tldr{{0}} r8, [sp, #-4] @ restore saved
'''.format(rng_address) # add rX r8 rY 
      self.save_psr = '''
\tldr r7, ={0}           @ load TRNG address
\tldr r7, [r7]           @ load from TRNG
\tmrs r7, apsr 
\tstr r7, [sp, #-16]
'''.format(rng_address) # another register needed to clean before and after; put a random in r7 whenever the saving process is finished
      self.load_psr = '''
\tldr r7, ={0}           @ load TRNG address
\tldr r7, [r7]           @ load from TRNG
\tldr r7, [sp, #-16]
\tmsr apsr, r7
'''.format(rng_address)
    else : raise Exception(f"Insufficient number of reserved registers: {self.reserved_registers}")
    ASMI.cfg=self

# ARM assembler instrumentation
@dataclass
class ASMI(object):
  text         : str  = ''
  is_directive : bool = field(init=False)
  is_label     : bool = field(init=False)
  is_comment   : bool = field(init=False)
  opcode       : str  | None = None
  operands     : list[str] | None = None
  label        : str  | None = None
  comment      : str  | None = None
  prefix       : str  = ''
  suffix       : str  = ''
  cfg = None # class variable, not initialized
  
  def __post_init__(self):
    s = self.text.strip()
    self.is_label     = True if s[-1] == ':' else False
    self.is_directive = True if not self.is_label and s[0]=='.' else False
    self.is_comment   = True if s[0]=='@' else False
    if self.is_comment : 
      self.comment  = s[2:]
    elif self.is_label :
      self.label    = s[:-1]
      return
    else :
      l = s.split()
      self.opcode   = l[0]
      try : 
        comment = l.index('@')
        self.operands = s.split()[1:comment]
      except ValueError : 
        self.operands = s.split()[1:]

  def operation(self):
    if self.opcode : return self.opcode
    if self.label  : return self.label
    if self.comment: return self.comment
    return self.text

  def is_load(self):
    if not self.opcode : return False
    if self.opcode[:2] == 'ld' : return True

  def is_store(self):
    if not self.opcode : return False
    if self.opcode[:2] == 'st' : return True
    
  def is_branch(self):
    if not self.opcode : return False
    if self.opcode[0] == 'b' : return True

  def is_mem(self):
    return self.is_load() or self.is_store()
    
  def is_compute(self):
    if self.is_label or self.is_directive or self.is_comment : return False
    return not (self.is_mem() or self.is_branch())

  def regs(self):
    try : return [ r for r in registers + special_registers if sum([ o.find(r)!=-1 for o in self.operands ]) ]
    except TypeError : return []

  def read_regs(self): # only works for write dest==first register
    try : return [ r for r in registers + special_registers if sum([ o.find(r)!=-1 for o in self.operands[1:] ]) ]
    except TypeError : return []

  def written_regs(self):
    if self.is_compute() or self.is_load() : return [ find_register(self.operands[0]) ]
    return []

  def is_function_dec(self):
    if self.opcode != '.type' : return False
    if self.operands[1] != '%function' : return False
    return self.operands[0][:-1]

  def is_conditioned(self):
    return self.opcode[-2:] in [ 'eq', 'ne', 'cs', 'hs', 'cc', 'lo', 'mi', 'vs', 'vc', 'hi', 'ls', 'ge', 'gt', 'le' ]
   
  def add_protection(self, needs_prologue=False):
    r = self.is_function_dec()
    if self.is_label :
      if needs_prologue==self.label:
        self.suffix=self.cfg.prologue
    if self.is_store() and 'str'==self.opcode[:3]:
      address = ' '.join(self.operands[1:])
      byte_spec = '' if len(self.opcode)<=3 else self.opcode[3:]
      self.prefix = self.cfg.store_random_value.format(byte_spec,address)
      return r
    regs = self.written_regs()
    if len(regs)==0 : return r 
    self.prefix=''
    for w in regs :
      if w in ['fp','sp','pc']: continue
      byte_spec = '' if len(self.opcode)<=3 or 'ldr'!=self.opcode[:3] else self.opcode[3:]
      if w in self.read_regs() : 
        if self.is_conditioned() : self.prefix += self.cfg.save_psr
        self.prefix += self.cfg.precharge_war_case.format(byte_spec,w)
        if self.is_conditioned() : self.prefix += self.cfg.load_psr
        # se l'operazione è condizionata e la condizione è falsa, devo eseguire invece add, rX, rX, #0
        self.text = self.text.replace(w, 'r8').replace('r8', w, 1) # replace all but first instance of w
        if self.is_conditioned() : 
          c = neg_cond(self.opcode[-2:])
          self.suffix += f'\tmov{c} {w}, r8\n'
      else :
        self.prefix += self.cfg.load_random_and_add_to_itself.format(byte_spec,w)
    return r
 
# Functions running over the entire code  
def read_asm(fname):
  with open(fname,'r') as fin :
    l = fin.readlines()
    r = [ASMI(i) for i in l if i.strip()!='']
  return r

def all_regs_used(asm):
  return set().union(*[ set(i.regs()) for i in asm ])

def protected_code(asm):
  res = ''
  for r in asm : 
    res += r.prefix + r.text + r.suffix
  return res

def write_protected_asm(asm,fname):
  needs_prologue=False
  for i in asm :
    needs_prologue = i.add_protection(needs_prologue)
  with open(fname,'w') as fout :
    fout.write(protected_code(asm))



if __name__ == '__main__':
  import argparse
  parser = argparse.ArgumentParser(
                    prog='asm_secure',
                    description='Add random precharging to ARM assembly code',
                    epilog='author: G. Agosta\n(c) Politecnico di Milano 2023')
  parser.add_argument('-v', '--verbose', action='store_true', help='print minimal information (for now)')
  parser.add_argument('-r', '--reserved-regs', default='autodetect', choices=[2,3,'autodetect'], help='number of reserved registers in the assembly file; must be 2 or 3; omit for autodetection')
  parser.add_argument('filename', help='ARM assembler file; modified by the program')
  args = parser.parse_args()
  if args.verbose:
    print(args, sys.stderr)
  fn = args.filename
  rg = args.reserved_regs if args.reserved_regs != 'autodetect' else fn
  try : cfg = Cfg(reserved_registers=rg)
  except Exception: 
    print(f"File {fn} skipped!")
    sys.exit(0)
  asm = read_asm(fn)
  '''
  for i in asm :
    print(i.operation(), i.regs())
  print(all_regs_used(asm))  
  for i in asm : 
    i.add_protection()
  print('---------------------------------------------------------------')
  print(protected_code(asm))
  '''
  write_protected_asm(asm,fn)
    
  
