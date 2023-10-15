import os
import platformio
import subprocess
import sys

project_dir = os.path.abspath(os.getcwd())
source_dir = project_dir + "/src"

# Use platformio's gcc-arm-none-eabi
#compiler = subprocess.check_output(['which', 'arm-none-eabi-gcc']).strip().decode()
compiler = subprocess.check_output(['which', 'arm-none-eabi-gcc']).strip().decode()
python = subprocess.check_output(['which', 'python']).strip().decode()
precharger = f"\"{project_dir}/scripts/precharger/asm_secure.py\""

flags = "-DSECURITY_LEVEL=128 -D_M4_ASM_ -DCORTEX_M4 -DMASK_ENABLE -O3 -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16"

# Select which files should be preprocessed
codes_sources = [
    #"code.c",
    "reed_muller.c",
    "reed_solomon.c"
]
common_sources = [
    #"parsing.c",
    #"vector.c"
]
fastmul_sources = [
    "bc_2.c",
    "bmul2.c",
    "btfy_consts_gft.c",
    "btfy_ffft.c",
    "cvt_to_fft_asm.s",
    "encode_asm.s",
    "encode.c",
    "gft_mul_vi_asm.s",
    "gft_mul_vi.c",
    "irepr_s8_asm.s",
    "repr_s8_asm.s"
]
fields_sources = [
    "fft.c",
    "gf.c",
    #"gf2x.c",
]
hqc_sources = [
    #"hqc.c",
    #"kem.c"
]
lib_sources = [
    #"fips202_masked.c",
    #"fips202.c",
    #"shake_ds.c",
    #"shake_prng.c"
]

toPrecharge = []
toPrecharge.extend([f"codes/{file}" for file in codes_sources])
toPrecharge.extend([f"common/{file}" for file in common_sources])
toPrecharge.extend([f"fastmul/{file}" for file in fastmul_sources])
toPrecharge.extend([f"fields/{file}" for file in fields_sources])
toPrecharge.extend([f"hqc/{file}" for file in hqc_sources])
toPrecharge.extend([f"lib/{file}" for file in lib_sources])

# add include paths
include_dirs = ["codes", "common", "fastmul", "fields", "hqc", "lib", "testing"]
include_dirs = [f"{source_dir}/{inc_dir}" for inc_dir in include_dirs]
include_dirs.append("/usr/arm-none-eabi/include/libopencm3/stm32/l4")
include_dirs.append("/usr/arm-none-eabi/include/libopencm3/stm32")

compiler_include_dirs = ""
for inc_dir in include_dirs:
    compiler_include_dirs += f"-I\"{inc_dir}\" "

print(compiler_include_dirs)
# Prints the build_src_filter to be written in the platformio.ini
# to exclude .c files in favor of the precharged .s files (in src/precharged)
dryRun = input("Dry run to print build_src_filter? [y/N]:\n")
if dryRun == "Y" or dryRun == "y":
    print("build_src_filter =")
    print("\t+<*>")
    print("\t-<hqc/main_hqc.c>") 
    print("\t-<hqc/main_kat.c>")
    for file in toPrecharge:
        print(f"\t-<{file}>")
    sys.exit(1)

os.system(f"mkdir -p {source_dir}/precharged")
for file in toPrecharge:
    # gcc-arm-none-eabi -DSECURITY_LEVEL=128 -S source.c -o source.s
    filename, extension = os.path.splitext(os.path.basename(file))
    asm_file = f"\"{source_dir}/precharged/{filename}.s\""
    if(extension != ".s"):
        command = f"{compiler} {flags} -S {compiler_include_dirs} \"{source_dir}/{file}\" -o {asm_file}"
    else:
        command = f"cp \"{source_dir}/{file}\" {asm_file}"
    os.system(command)
    # python asm_secure.py source.s
    command = f"{python} {precharger} {asm_file}"
    os.system(command)  
