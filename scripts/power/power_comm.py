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
    parser.add_argument("-c", "--check", action="store_true", help="Verify correctness of results")
    args = parser.parse_args()

    ser = serial.Serial(args.port, baudrate=args.rate)
    ser.flush()
    ser.write(b"RDY\n")
    ok = ser.readline()  # receive OK
    ser.flush()

    pk, sk = keygen()
    store_keys(pk, sk)
    ser.write(bytes.fromhex(pk))
    ser.write(bytes.fromhex(sk))

    if args.algorithm == "enc":
        m = gen_msg()
        for i in range(0, args.batch_size):
            if not args.fixed:
                m = gen_msg()

            print("Round {}... ".format(i))
            ser.write(bytes.fromhex(m))
            ser.flush()

            if args.check:
                u = ser.readline().decode("utf-8").strip()
                v = ser.readline().decode("utf-8").strip()
                store_ctx(u, v)
                m_out = decrypt()
                if m == m_out:
                    print("OK")
                else:
                    print("FAIL")
                    print(m)
                    print(m_out)


            ok = ser.readline().decode("utf-8")  # wait DONE
    else:
        m = gen_msg()
        u, v = encrypt()
        for i in range(0, args.batch_size):
            if not args.fixed:
                m = gen_msg()
                u, v = encrypt()

            print("Round {}... ".format(i))
            ser.write(bytes.fromhex(u))
            ser.flush()
            ser.write(bytes.fromhex(v))
            ser.flush()

            if args.check:
                m_out = ser.readline().decode("utf-8").strip()
                if m == m_out:
                    print("OK")
                else:
                    print("FAIL")
                    print(m)
                    print(m_out)

            ok = ser.readline().decode("utf-8")  # wait DONE

    ser.close()
    #delete files
    os.remove("m")
    os.remove("pk")
    os.remove("sk")
    os.remove("u")
    os.remove("v")


def gen_msg():
    return subprocess.check_output(["xxd", "-l", "16", "-p", "/dev/urandom"]).decode("utf-8").strip()

def store_keys(pk, sk):
    with open("pk", "w") as f:
        f.write(pk)
    with open("sk", "w") as f:
        f.write(sk)

def store_ctx(u, v):
    with open("u", "w") as f:
        f.write(u)
    with open("v", "w") as f:
        f.write(v)

def keygen():
    keys = subprocess.run("./keygen", capture_output=True).stdout.strip().decode("utf-8").split('\n')
    return keys[0], keys[1]

def encrypt():
    ctx = subprocess.run("./encrypt", capture_output=True).stdout.split("\n").strip().decode("utf-8")
    return ctx[0], ctx[1]

def decrypt():
    return subprocess.run("./decrypt", capture_output=True).stdout.strip().decode("utf-8")

def cvt_to_bytes(l):
    return b"".join([bytes.fromhex(x) for x in l])

if __name__ == "__main__":
    main()
