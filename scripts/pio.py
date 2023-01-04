Import("env")

# Do not run a script when external applications, such as IDEs,
# dump inetgration data. Otherwise, input() will block the process
# waiting for the user input
if env.IsIntegrationDump():
    # stop the current script execution
    print("Running in IDE, returning...")
    Return()

print("Security level: manually set to 128")
env.Append(CPPDEFINES=[("SECURITY_LEVEL", 128)])
env.Append(CPPDEFINES=[("_M4_ASM_", 1)])

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

debug = input("Enable debug messages [Y/n]: \n")
if debug == "N" or debug == "n":
    print("Debug disabled")
else:
    env.Append(CPPDEFINES=[("DEBUG")])
    print("Debug enabled")

timing = input("Enable timing [Y/n]: \n")
if timing == "N" or timing == "n":
    print("Timing disabled")
    print("\nExecutable(s) to run")
    print("[0] PKE Encryption")
    print("[1] PKE Decryption")
    print("[2] KEM Encapsulation")
    print("[3] KEM Decapsulation")
    executables = input("Select executables to run: \n")
    if executables == "":
        executables = "2 3"   
    executables = executables.split()
    executables = [x for x in executables if x != " "]
    executables = [int(x) for x in executables]
    for executable in executables:
        if executable == 0:
            env.Append(CPPDEFINES=[("PKE_ENCRYPT")])
        elif executable == 1:
            env.Append(CPPDEFINES=[("PKE_DECRYPT")])
        elif executable == 2:
            env.Append(CPPDEFINES=[("KEM_ENCAPS")])
        elif executable == 3:
            env.Append(CPPDEFINES=[("KEM_DECAPS")])
else:
    env.Append(CPPDEFINES=[("TIMING")])
    print("Timing enabled")
    print("\nExecutable(s) to run")
    print("[0] Encrypt/Decrypt")
    print("[1] Encaps/Decaps")
    print("[2] Multiplication")
    executables = input("Select executables to run: \n")
    if executables == "":
        executables = "0"   
    executables = executables.split()
    executables = [x for x in executables if x != " "]
    executables = [int(x) for x in executables]
    for executable in executables:
        if executable == 0:
            env.Append(CPPDEFINES=[("PKE")])
        elif executable == 1:
            env.Append(CPPDEFINES=[("KEM")])
        elif executable == 2:
            env.Append(CPPDEFINES=[("MUL")])
