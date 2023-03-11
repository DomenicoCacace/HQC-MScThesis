import argparse
import os
import serial
import subprocess
import sys
import time

def main(): 
    parser = argparse.ArgumentParser()
    parser.add_argument("-b", "--batch_size", type=int, default=1000, help="Number of samples to take for each algorithm")
    parser.add_argument("-p", "--port", type=str, default="/dev/ttyACM0", help="Serial port to use")
    parser.add_argument("-r", "--rate", type=int, default=115200, help="Baud rate to use")
    parser.add_argument("-a", "--algorithm", type=str, default="enc", help="Algorithm to run (enc, dec)")
    parser.add_argument("-f", "--fixed", action="store_true", help="Use fixed message and key")
    args = parser.parse_args()

    ser = serial.Serial(args.port, baudrate=args.rate)
    ser.write(b"RDY\n")
    ser.readline()  # receive OK

    pk, sk = keygen()
    ser.write(cvt_to_bytes(pk))
    ser.write(cvt_to_bytes(sk))


    m = gen_msg()
    if args.algorithm == "enc":
        for i in range(0, args.batch_size):
            if not args.fixed:
                m = gen_msg()

            print("Round {}... ".format(i))
            ser.write(cvt_to_bytes(m))

            ser.readline().decode("utf-8")  # wait DONE
    else:
        m = gen_msg()
        u, v = encrypt()
        for i in range(0, args.batch_size):
            if not args.fixed:
                m = gen_msg()
                u, v = encrypt()

            print("Round {}... ".format(i))
            ser.write(cvt_to_bytes(u))
            ser.write(cvt_to_bytes(v))

            ser.readline().decode("utf-8")  # send DONE

    ser.close()
    #delete files
    os.remove("m")
    os.remove("pk")
    os.remove("sk")
    os.remove("u")
    os.remove("v")


def gen_msg():
    m = subprocess.check_output(["xxd", "-l", "16", "-p", "/dev/urandom"]).decode("utf-8").strip()
    _m = []
    for i in range(0, len(m), 2):
        _m.append(m[i:i+2])
    fp = open("m", "w")
    for x in _m:
        fp.write("{} ".format(x.zfill(2)))
    fp.write("\n")
    fp.close()
    return _m

def keygen():
    subprocess.call(["./keygen"])
    fp = open("pk", "r")
    pk = fp.readline().strip().split(' ')
    fp.close()
    fp = open("sk", "r")
    sk = fp.readline().strip().split(' ')
    fp.close()
    return pk, sk

def encrypt():
    subprocess.call(["./encrypt"])
    fp = open("u", "r")
    u = fp.readline().strip().split(' ')
    fp.close()
    fp = open("v", "r")
    v = fp.readline().strip().split(' ')
    fp.close()
    return u, v

def cvt_to_bytes(l):
    return b"".join([bytes.fromhex(x) for x in l])

if __name__ == "__main__":
    main()