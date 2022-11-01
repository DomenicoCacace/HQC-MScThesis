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

debug = input("Enable debug messages [y/N]: \n")
if debug == "Y" or debug == "y":
    env.Append(CPPDEFINES=[("DEBUG")])
    print("Debug enabled")
else:
    print("Debug disabled")

print("\nExecutable(s) to run")
print("[0] PKE Encryption")
print("[1] PKE Decryption")
print("[2] KEM Encapsulation")
print("[3] KEM Decapsulation")
executables = input("Select executables to run: \n")
executables = executables.split()
executables = [x for x in executables if x != " "]
executables = [int(x) for x in executables]
for executable in executables:
    if executable == 0:
        env.Append(CPPDEFINES=[("PKE_ENCRYPT")])
        if "PKE" not in env["CPPDEFINES"]:
            env.Append(CPPDEFINES=[("PKE")])
    elif executable == 1:
        env.Append(CPPDEFINES=[("PKE_DECRYPT")])
        if "PKE" not in env["CPPDEFINES"]:
            env.Append(CPPDEFINES=[("PKE")])
    elif executable == 2:
        env.Append(CPPDEFINES=[("KEM_ENCAPS")])
        if "KEM" not in env["CPPDEFINES"]:
            env.Append(CPPDEFINES=[("KEM")])
    elif executable == 3:
        env.Append(CPPDEFINES=[("KEM_DECAPS")])
        if "KEM" not in env["CPPDEFINES"]:
            env.Append(CPPDEFINES=[("KEM")])



    
