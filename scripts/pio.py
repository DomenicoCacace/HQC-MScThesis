import os
Import("env")

# Do not run a script when external applications, such as IDEs,
# dump inetgration data. Otherwise, input() will block the process
# waiting for the user input
if env.IsIntegrationDump():
    # stop the current script execution
    print("Running in IDE, returning...")
    Return()
    
project_dir = os.path.abspath(os.getcwd())
# Add subdirectories to CPPPATH
env.Append(CPPPATH=[project_dir + "/src/codes"])
env.Append(CPPPATH=[project_dir + "/src/common"])
env.Append(CPPPATH=[project_dir + "/src/fields"])
env.Append(CPPPATH=[project_dir + "/src/hqc"])
env.Append(CPPPATH=[project_dir + "/src/lib"])
env.Append(CPPPATH=[project_dir + "/src/sparsemul"])
env.Append(CPPPATH=[project_dir + "/src/testing"])

print("Security level: manually set to 128")
env.Append(CPPDEFINES=[("SECURITY_LEVEL", 128)])
env.Append(CPPDEFINES=[("CORTEX_M4")])
env.Append(CPPDEFINES=[("_M4_ASM_")])

# Select the communication interface
print("Communication Interface\n[0] STLINK (Default)\n[1] USART2")
try:
    usart = int(input("Select communication interface: \n"))
except ValueError:
    usart = 0
if usart == 1:
    env.Append(CPPDEFINES=[("USART2_COMM")])
    print("USART2 selected")
else:
    env.Append(CPPDEFINES=[("STLINK_COMM")])
    print("STLINK selected")


# Enable/disable debug messages
debug = input("Enable debug messages [Y/n]: \n")
if debug == "N" or debug == "n":
    print("Debug disabled")
else:
    env.Append(CPPDEFINES=[("DEBUG")])
    print("Debug enabled")


# Select the operating mode
print("Operating mode\n[0] Functional (Default)\n[1] Timing\n[2] Plain\n")
try:
    mode = int(input("Select operating mode: \n"))
except ValueError:
    mode = 0
if mode == 0:
    env.Append(CPPDEFINES=[("MODE", "0")])
elif mode == 1:
    env.Append(CPPDEFINES=[("MODE", "1")])
elif mode == 2:
    env.Append(CPPDEFINES=[("MODE", "2")])


# Select what algorithm(s) to run
if mode == 0:
    print("Algorithm\n[0] PKE (Default)\n[1] KEM\n[2] Multiplication\n")
    try:
        alg = int(input("Select algorithm: \n"))
    except ValueError:
        alg = 0

    if alg == 0:
        env.Append(CPPDEFINES=[("ALG", "FULL_PKE")])
    elif alg == 1:
        env.Append(CPPDEFINES=[("ALG", "FULL_KEM")]) 
    elif alg == 2:
        env.Append(CPPDEFINES=[("ALG", "MULT")])
        
if mode == 2 or mode == 1:   # PLAIN/TIMING
    print("Algorithm\n[0] PKE (Default)\n[1] KEM\n[2] Multiplication\n[3] Encrypt\n[4] Decrypt\n[5] Encaps\n[6] Decaps\n[7] Keygen\n")
    try:
        alg = int(input("Select algorithm: \n"))
    except ValueError:
        alg = 0

    if alg == 0:
        env.Append(CPPDEFINES=[("ALG", "FULL_PKE")])
    elif alg == 1:
        env.Append(CPPDEFINES=[("ALG", "FULL_KEM")])
    elif alg == 2:
        env.Append(CPPDEFINES=[("ALG", "MULT")])
    elif alg == 3:
        env.Append(CPPDEFINES=[("ALG", "ENCRYPT")])
    elif alg == 4:
        env.Append(CPPDEFINES=[("ALG", "DECRYPT")])
    elif alg == 5:
        env.Append(CPPDEFINES=[("ALG", "ENCAPS")])
    elif alg == 6:
        env.Append(CPPDEFINES=[("ALG", "DECAPS")])
    elif alg == 7:
        env.Append(CPPDEFINES=[("ALG", "KEYGEN")])
        
