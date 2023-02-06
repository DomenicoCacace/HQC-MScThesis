import os
import serial
import subprocess
import sys

branches = ["reference", "reference_noshuffle" "fastmul", "sparsemul", "masking"]
algs = ["pke", "kem", "mul", "enc", "dec", "encaps", "decaps", "keygen"]
freqs = ["16", "32", "48", "64", "80"]
batch_size = 1000

def main(): 
    if len(sys.argv) > 1:
        try:
            batch_size = int(sys.argv[1])
        except ValueError:
            pass

    for branch in branches:
        print("Checking out {}".format(branch))
        os.system("git checkout {} > /dev/null".format(branch))
        commit = subprocess.check_output(["git", "rev-parse", "HEAD"]).decode("utf-8").strip()[0:7]
        if not os.path.isfile("../docs/ttest_ARM.csv"):
            f = open("../docs/ttest_ARM.csv", "w")
            f.write("commit,branch,algorithm,t,freq,notes\n")
        else:
            f = open("../docs/ttest_ARM_.csv", "a")
            f.write("\n")
        for j in range(0, len(freqs)):
            for i in range(0, len(algs)):
                print("    Running {}...".format(algs[i]), end="\r")
                build(i, j)
                result = getResults()
                print("    {} done! ({})".format(algs[i], result))
                f.write("{},{},{},{},{},{},\n".format(commit, branch, algs[i], result, freqs[j]))
        f.close()
        os.system("git add ../docs/ttest_ARM.csv")
        os.system("git commit -m \"Add ARM t-test results\"".format(branch))
        print()
    

def build(alg):
    p = subprocess.Popen(["platformio", "run", "-t", "upload", "-c", "../platformio.ini", "-d", "../"], stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)

    while True:
        line = p.stdout.readline()
        if "Select communication interface:" in line:
            p.stdin.write("0\n")
            p.stdin.flush()
        elif "Enable debug messages [Y/n]: \n" in line:
            p.stdin.write("Y\n")
            p.stdin.flush()
        elif "Select operating mode:" in line:
            p.stdin.write("3\n")
            p.stdin.flush()
        elif "Select algorithm:" in line:
            p.stdin.write("{}\n".format(alg))
            p.stdin.flush()
        elif "Number of iterations:" in line:
            p.stdin.write("{}\n".format(batch_size))
            p.stdin.flush()
            break
    # wait for the subprocess to terminate
    p.wait()

def getResults():
    ser = serial.Serial("/dev/ttyACM0", baudrate=9600)
    lines = ["", ""]
    while True:
        lines[0] = lines[1]
        line = ser.readline().decode("utf-8")
        if "DONE" in line:
            break
        lines[1] = line
    return lines[0].strip()


if __name__ == "__main__":
    main()
