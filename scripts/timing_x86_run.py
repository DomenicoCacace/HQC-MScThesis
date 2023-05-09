import os
import serial
import subprocess
import sys

branches = ["reference", "reference_noshuffle", "sparsemul", "masking", "fastmul", "avx"]
algs = ["FULL_PKE", "FULL_KEM", "MULT", "ENC", "DEC", "ENCAPS", "DECAPS", "KEYGEN"]
alg_names = ["pke", "kem", "mul", "enc", "dec", "encaps", "decaps", "keygen"]
branches = ["fastmul"]
def main(): 
    if len(sys.argv) > 1:
        try:
            batch_size = int(sys.argv[1])
        except ValueError:
            batch_size = 10000
    else:
        batch_size = 10000
            
    for branch in branches:
        if branch == "masking" or branch == "fastmul": # only support 128-bit security level
            seclevs = ["128"]   
        else:
            seclevs = ["128", "192", "256"]
        print("Checking out {}".format(branch))
        os.system("git checkout {} > /dev/null".format(branch))
        commit = subprocess.check_output(["git", "rev-parse", "HEAD"]).decode("utf-8").strip()[0:7]

        if not os.path.isfile("../docs/timing_x86.csv"):
            f = open("../docs/timing_x86.csv", "w")
            f.write("commit,branch,seclvl,algorithm,mean,var,notes\n")
            f.close()
        else:
            f = open("../docs/timing_x86.csv", "a")
            f.write("\n")
            f.close()

        for lvl in seclevs:
            for i in range(len(algs)):
                alg = algs[i]
                print("    Running {}...".format(alg), end="\r")
                build(alg, lvl, batch_size)
                result = getResults(lvl)
                print("    {} done! ({}, {})".format(alg, result[0], result[1]))
                f = open("../docs/timing_x86.csv", "a")
                f.write("{},{},{},{},{},{},\n".format(commit, branch, lvl, alg_names[i], result[0], result[1]))
                f.close()
        os.system("git add ../docs/timing_x86.csv")
        os.system("git commit -m \"Add x86 timing results\"".format(branch))
        print()
    

def build(alg, seclvl, batch_size):
    command = "cmake -S ../ -B ../build -DSECLVL={} -DALG={} -DBATCH_SIZE={} -DMODE=1".format(seclvl, alg, batch_size)
    p = subprocess.Popen(command.split(' '), stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
    p.wait()
    command = "cmake --build ../build"
    p = subprocess.Popen(command.split(' '), stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
    p.wait()

def getResults(seclvl):
    p = subprocess.Popen(["./../build/hqc-{}".format(seclvl)], stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
    output = p.communicate()[0]
    times = output.split("\n")[0]
    return times.split(",")


if __name__ == "__main__":
    main()
