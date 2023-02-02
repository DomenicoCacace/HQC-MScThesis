import os
import serial
import subprocess

branches = ["main", "fastmul", "sparsemul", "masking"]
algs = ["pke", "kem", "mul", "enc", "dec", "encaps", "decaps", "keygen"]

def main(): 
    for branch in branches:
        print("Checking out {}".format(branch))
        os.system("git checkout {} > /dev/null".format(branch))
        commit = subprocess.check_output(["git", "rev-parse", "HEAD"]).decode("utf-8").strip()[0:7]
        f = open("../docs/timing_ARM.csv", "w")
        f.write("commit,branch,algorithm,mean,var\n")
        for i in range(0, len(algs)):
            #print without newline
            print("    Running {}...".format(algs[i]), end="\r")
            build(i)
            result = getResults()
            print("    {} done! ({}s, {}s)".format(algs[i], result[0], result[1]))
            f.write("{},{},{},{},{}\n".format(commit, branch, algs[i], result[0], result[1]))
        f.close()
        os.system("git add ../docs/timing_ARM.csv")
        os.system("git commit -m \"Add ARM timing results\"".format(branch))
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
            p.stdin.write("1\n")
            p.stdin.flush()
        elif "Select algorithm:" in line:
            p.stdin.write("{}\n".format(alg))
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
    return lines[0].strip().split(",")





if __name__ == "__main__":
    main()
