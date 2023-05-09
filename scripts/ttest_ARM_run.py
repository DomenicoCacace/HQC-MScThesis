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
        rate = 115200

    branch = subprocess.check_output(["git", "rev-parse", "--abbrev-ref", "HEAD"]).decode("utf-8").strip()
    commit = subprocess.check_output(["git", "rev-parse", "HEAD"]).decode("utf-8").strip()[0:7]
    if not os.path.isfile("../docs/ttest_ARM.csv"):
        f = open("../docs/ttest_ARM.csv", "w")
        f.write("commit,branch,freq,algorithm,mean,var,notes\n")
        f.close()
    else:
        f = open("../docs/ttest_ARM.csv", "a")
        f.write("\n")
        f.close()
    
    for j in range(0, len(freqs)):
        print("    Running PKE...")
        build(0, j, batch_size)
        pke, enc, dec = getResults_PKE(port, rate)
        f = open("../docs/ttest_ARM.csv", "a")
        f.write("{},{},{},{},{},\n".format(commit, branch, freqs[j], "pke", pke))
        f.write("{},{},{},{},{},\n".format(commit, branch, freqs[j], "enc", enc))
        f.write("{},{},{},{},{},\n".format(commit, branch, freqs[j], "dec", dec))
        f.close()
        print("    Running KEM...")
        build(1, j, batch_size)
        kem, encaps, decaps = getResults_KEM(port, rate)
        f = open("../docs/ttest_ARM.csv", "a")
        f.write("{},{},{},{},{},\n".format(commit, branch, freqs[j], "kem", kem))
        f.write("{},{},{},{},{},\n".format(commit, branch, freqs[j], "encaps", encaps))
        f.write("{},{},{},{},{},\n".format(commit, branch, freqs[j], "decaps", decaps))
        f.close()
        print("    Running MUL...")
        build(2, j, batch_size)
        mul = getResults_MUL(port, rate)
        f = open("../docs/ttest_ARM.csv", "a")
        f.write("{},{},{},{},{},\n".format(commit, branch, freqs[j], "mul", mul))
        f.close()
    os.system("git add ../docs/ttest_ARM.csv")
    os.system("git commit -m \"Add ARM t-test results\"".format(branch))
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
            p.stdin.write("4\n")
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
        lines.append(line.split(": ")[1])
    return lines[0], lines[1], lines[2]

def getResults_KEM(port, rate):
    ser = serial.Serial(port, baudrate=rate)
    lines = []
    while True:
        line = ser.readline().decode("utf-8").strip()
        if "DONE" in line:
            break
        lines.append(line.split(": ")[1])
    return lines[0], lines[1], lines[2]

def getResults_MUL(port, rate):
    ser = serial.Serial(port, baudrate=rate)
    lines = []
    while True:
        line = ser.readline().decode("utf-8").strip()
        if "DONE" in line:
            break
        lines.append(line.split(": ")[1])
    return lines[0]



if __name__ == "__main__":
    main()
