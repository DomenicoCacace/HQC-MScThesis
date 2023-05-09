from subprocess import Popen, PIPE
from time import sleep
from sys import exit
import argparse

def main():
    parser = argparse.ArgumentParser(description='Test the configuration')
    parser.add_argument("-m", "--masks", action="store_true", help="Enable masking")
    parser.add_argument("-d", "--project-dir", type=str, default="../../", help="Root of the platformio project")
    parser.add_argument("-b", "--batch-size", type=int, default=1000, help="Number of samples to take for each algorithm")
    parser.add_argument("-a", "--algorithm", type=str, default="enc", help="Algorithm to run (enc, dec)")
    args = parser.parse_args()

    p = Popen(["pio", "run", "-t", "upload", "-d", args.project_dir], stdin=PIPE, stdout=PIPE)
    # communication interface: USART
    p.stdin.write(b"1\n")
    sleep(0.1)

    # enable debug messages: yes
    p.stdin.write(b"y\n")
    sleep(0.1)

    # clock frequency: 80 MHz
    p.stdin.write(b"4\n")
    sleep(0.1)

    # operating mode: power
    p.stdin.write(b"6\n")
    sleep(0.1)

    # algorithm
    if args.algorithm == "enc":
        p.stdin.write(b"0\n")
    else:
        p.stdin.write(b"1\n")
    sleep(0.1)

    # masking
    if args.masks:
        p.stdin.write(b"y\n")
    else:
        p.stdin.write(b"n\n")
    sleep(0.1)

    # batch size
    p.stdin.write(f"{args.batch_size}\n".encode())
    sleep(0.1)
    
    exit(0)

        
if __name__ == "__main__":
    main()
