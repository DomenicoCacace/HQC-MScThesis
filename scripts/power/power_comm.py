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
    ser.write(cvt_to_bytes(pk))
    ser.flush()
    ser.write(cvt_to_bytes(sk))
    ser.flush()

    if args.algorithm == "enc":
        m = gen_msg()
        for i in range(0, args.batch_size):
            if not args.fixed:
                m = gen_msg()

            print("Round {}... ".format(i))
            ser.write(cvt_to_bytes(m))
            ser.flush()

            if args.check:
                u = ser.readline().decode("utf-8").strip().split(' ')
                v = ser.readline().decode("utf-8").strip().split(' ')
                store_ctx(u, v)
                m_out = decrypt()
                if m == m_out:
                    print("OK")
                else:
                    print("FAIL")


            ok = ser.readline().decode("utf-8")  # wait DONE
    else:
        m = gen_msg()
        u, v = encrypt()
        for i in range(0, args.batch_size):
            if not args.fixed:
                m = gen_msg()
                u, v = encrypt()

            print("Round {}... ".format(i))
            ser.write(cvt_to_bytes(u))
            ser.flush()
            ser.write(cvt_to_bytes(v))
            ser.flush()

            if args.check:
                m_out = ser.readline().decode("utf-8").strip().split(' ')
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
    m = subprocess.check_output(["xxd", "-l", "16", "-p", "/dev/urandom"]).decode("utf-8").strip()
    _m = []
    for i in range(0, len(m), 2):
        _m.append(m[i:i+2])
    fp = open("m_in", "w")
    for x in _m:
        fp.write("{} ".format(x.zfill(2)))
    fp.write("\n")
    fp.close()
    return _m

def store_ctx(u, v):
    fp = open("u", "w")
    for i in u:
        fp.write("{}".format(i))
    fp.write("\n")
    fp.close()
    fp = open("v", "w")
    for i in v:
        fp.write("{}".format(i))
    fp.write("\n")
    fp.close()


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

def decrypt():
    subprocess.call(["./decrypt"])
    fp = open("m_out", "r")
    m = fp.readline().strip().split(' ')
    fp.close()
    return m

def cvt_to_bytes(l):
    return b"".join([bytes.fromhex(x) for x in l])

if __name__ == "__main__":
    main()