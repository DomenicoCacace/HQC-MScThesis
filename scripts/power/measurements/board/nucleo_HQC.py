import serial
import numpy as np

import subprocess

from os import system

class nucleo_HQC:
    def __init__(self,batch_size=50,exec_folder = "", mode="enc"):
        self.board_name = "STM Nucleo F476 board - HQC binary"
        self.current_input = bytearray()
        self.processed_input_count = 0
        self.batch_size = batch_size 
        self.key = []
        self.scheduled_keys = []
        self.uart = None
        self.mode = mode
        self.keygen = exec_folder + "keygen"
        self.encrypt = exec_folder + "encrypt"
        self.decrypt = exec_folder + "decrypt"
        self.exec_folder = exec_folder
        return

    def init_serial(self,pathname_port):
        self.uart = serial.Serial(pathname_port)
        self.uart.baudrate=115200 
        self.uart.bytesize=8 
        self.uart.parity='N' 
        self.uart.stopbits=1
        self.uart.timeout=None
        self.uart.xonxoff=0
        self.uart.rtscts=0  
        self.uart.reset_input_buffer()
        self.uart.reset_output_buffer()
        return
    
    def reset_board(self,board_serial):
        system(f"st-flash --serial {board_serial} reset")

    def process_input_and_check(self, checked_inputs, output_size):
        if self.mode == "enc":
            self.process_input_and_check_enc(checked_inputs, output_size)
        else:
            self.process_input_and_check_dec(checked_inputs, output_size)

        return
    
    # This method sends the input to the board, waits for the results and checks
    # it. 
    # The expected HQC outputs are computed by a standalone binary 
    # It fills processed_data with the processed inputs
    def process_input_and_check_enc(self, checked_plaintexts, ciphertext_size):
        for i in range(self.batch_size):
            # generate keypair
            keys = subprocess.run(self.keygen, capture_output=True).stdout.split('\n')
            pk = keys[0]
            sk = keys[1]
            print("pk: ", pk)
            print("sk: ", sk)

            # generate message
            m_in = subprocess.check_output(["xxd", "-l", "16", "-p", "/dev/urandom"]).decode("utf-8").strip()
            print("m: ", m_in)

            # send keypair
            self.send(bytes.fromhex(pk))
            self.send(bytes.fromhex(sk))

            # send message
            self.send(bytes.fromhex(m_in))

            # receive ciphertext
            u = self.recv(ciphertext_size[0])
            v = self.recv(ciphertext_size[1])

            print("u: ", u)
            print("v: ", v)

            # decrypt ciphertext
            with open(self.exec_folder+"u", "w") as f:
                f.write(u.hex())
            with open(self.exec_folder+"v", "w") as f:
                f.write(v.hex())
            with open(self.exec_folder+"sk", "w") as f:
                f.write(sk)
            
            m_out = subprocess.run(self.decrypt, capture_output=True).stdout.strip()

            # remove files
            system("rm u v sk")
            
            if(m_in != m_out):
                print(f"Getting  m {bytes.hex(m_out)}")
                print(f"Computed m {bytes.hex(m_in)}")
            else:
                print("Board-side and Host side results match")
                checked_plaintexts[i] = m_out

        return
        
    def send(self,data):
        written = self.uart.write(data)
        self.uart.flush()
        return written

    def recv(self,amount):
        return self.uart.read(amount)
