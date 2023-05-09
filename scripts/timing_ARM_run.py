import os
import serial
import subprocess
import sys

algs = ["pke", "kem", "mul"]
freqs = ["16", "32", "48", "64", "80"]

def main(): 
    if len(sys.argv) > 1:
        try:
            batch_size = int(sys.argv[1])
        except ValueError:
            batch_size = 1000
    else:
        batch_size = 1000

    if len(sys.argv) > 2:
        port = sys.argv[2]
    else:
        port = "/dev/ttyACM0"

    if len(sys.argv) > 3:
        rate = int(sys.argv[3])
    else:
        rate = 9600

    branch = subprocess.check_output(["git", "rev-parse", "--abbrev-ref", "HEAD"]).decode("utf-8").strip()
    commit = subprocess.check_output(["git", "rev-parse", "HEAD"]).decode("utf-8").strip()[0:7]
    if not os.path.isfile("../docs/timing_ARM.csv"):
        f = open("../docs/timing_ARM.csv", "w")
        f.write("commit,branch,freq,algorithm,mean,var,notes\n")
        f.close()
    else:
        f = open("../docs/timing_ARM.csv", "a")
        f.write("\n")
        f.close()

    for j in range(0, len(freqs)):
        print("    Running PKE...")
        build(0, j, batch_size)
        pke, enc, dec, keygen = getResults_PKE(port, rate)
        f = open("../docs/timing_ARM.csv", "a")
        f.write("{},{},{},{},{},{},\n".format(commit, branch, freqs[j], "pke", pke[0], pke[1]))
        f.write("{},{},{},{},{},{},\n".format(commit, branch, freqs[j], "enc", enc[0], enc[1]))
        f.write("{},{},{},{},{},{},\n".format(commit, branch, freqs[j], "dec", dec[0], dec[1]))
        f.write("{},{},{},{},{},{},\n".format(commit, branch, freqs[j], "keygen", keygen[0], keygen[1]))
        f.close()
        print("    Running KEM...")
        build(1, j, batch_size)
        kem, encaps, decaps = getResults_KEM(port, rate)
        f = open("../docs/timing_ARM.csv", "a")
        f.write("{},{},{},{},{},{},\n".format(commit, branch, freqs[j], "kem", kem[0], kem[1]))
        f.write("{},{},{},{},{},{},\n".format(commit, branch, freqs[j], "encaps", encaps[0], encaps[1]))
        f.write("{},{},{},{},{},{},\n".format(commit, branch, freqs[j], "decaps", decaps[0], decaps[1]))
        f.close()
        print("    Running MUL...")
        build(2, j, batch_size)
        mul = getResults_MUL(port, rate)
        f = open("../docs/timing_ARM.csv", "a")
        f.write("{},{},{},{},{},{},\n".format(commit, branch, freqs[j], "mul", mul[0], mul[1]))
        f.close()
    os.system("git add ../docs/timing_ARM.csv")
    os.system("git commit -m \"Add ARM timing results\"".format(branch))
    print("DONE")
    

def build(alg, freq, batch_size):
    p = subprocess.Popen(["platformio", "run", "-t", "upload", "-c", "../platformio.ini", "-d", "../"], stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)

    while True:
        line = p.stdout.readline()
        if "Select communication interface:" in line:
            p.stdin.write("0\n")
            p.stdin.flush()
        elif "Enable debug messages [Y/n]: \n" in line:
            p.stdin.write("Y\n")
            p.stdin.flush()
        elif "Select clock frequency:" in line:
            p.stdin.write("{}\n".format(freq))
            p.stdin.flush()
        elif "Select operating mode:" in line:
            p.stdin.write("5\n")
            p.stdin.flush()
        elif "Select algorithm:" in line:
            p.stdin.write("{}\n".format(alg))
            p.stdin.flush()
        elif "Number of iterations: " in line:
            p.stdin.write("{}\n".format(batch_size))   
            p.stdin.flush() 
            break
    # wait for the subprocess to terminate
    p.wait()

def getResults_PKE(port, rate):
    ser = serial.Serial(port, baudrate=rate)
    lines = []
    while True:
        line = ser.readline().decode("utf-8").strip()
        if "DONE" in line:
            break
        lines.append(line.split(": ")[1].split(","))
    return lines[0], lines[1], lines[2], lines[3]

def getResults_KEM(port, rate):
    ser = serial.Serial(port, baudrate=rate)
    lines = []
    while True:
        line = ser.readline().decode("utf-8").strip()
        if "DONE" in line:
            break
        lines.append(line.split(": ")[1].split(","))
    return lines[0], lines[1], lines[2]

def getResults_MUL(port, rate):
    ser = serial.Serial(port, baudrate=rate)
    lines = []
    while True:
        line = ser.readline().decode("utf-8").strip()
        if "DONE" in line:
            break
        lines.append(line.split(": ")[1].split(","))
    return lines[0]



if __name__ == "__main__":
    main()
