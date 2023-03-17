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

    def exchange_keys(self):
        # generate keypair
        print("Generate keypair...")
        keys = subprocess.run(self.keygen, capture_output=True).stdout.strip().decode("utf-8").split('\n')
        pk = keys[0]
        sk = keys[1]
        #print("pk: ", pk)
        #print("sk: ", sk)
        print("Done!\n")

        # save keys to file
        with open("pk", "w") as f:
            f.write(pk)
        with open("sk", "w") as f:
            f.write(sk)
            

        # init comm
        self.send(b"RDY\n")
        ok = self.recv(3)
            
        # send keypair
        print("Sending keys...")
        self.send(bytes.fromhex(pk))
        self.send(bytes.fromhex(sk))
        print("Keys sent, board waiting for inputs")

    def gen_msg(self):
        return subprocess.check_output(["xxd", "-l", "16", "-p", "/dev/urandom"]).decode("utf-8").strip()

    def gen_ctx(self, m_in):
        with open("m_in", "w") as f:
            f.write(m_in)
        ctx = subprocess.run(self.encrypt, capture_output=True).stdout.strip().decode("utf-8").split('\n')
        return ctx[0], ctx[1]
    
    def generate_inputs(self):
        m = self.gen_msg()
        if self.mode == "enc":
            return m
        else:
            u, v = self.gen_ctx(m)
            return [u, v, m]
        
    def remove_files(self):
        system("rm pk sk")
        if self.mode == "enc":
            system("rm u v")
        else:
            system("rm m_in")

        return


    def process_input_and_check(self, inputs, output_size, checked_plaintexts):
        if self.mode == "enc":
            self.process_input_and_check_enc(inputs, output_size, checked_plaintexts)
        else:
            self.process_input_and_check_dec(inputs[0], inputs[1], inputs[2], output_size, checked_plaintexts)

        return
    
    # This method sends the input to the board, waits for the results and checks
    # it. 
    # The expected HQC outputs are computed by a standalone binary 
    # It fills processed_data with the processed inputs
    def process_input_and_check_enc(self, m_in, ciphertext_size, checked_plaintexts):   
        for i in range(0, self.batch_size):     
            # send message
            self.send(bytes.fromhex(m_in))
            
            # receive ciphertext
            u = self.recv(ciphertext_size[0]*2+1).strip().decode("utf-8")
            v = self.recv(ciphertext_size[1]*2+1).strip().decode("utf-8")

            #print("u: ", u)
            #print("v: ", v)
            # decrypt ciphertext
            with open("u", "w") as f:
                f.write(u)
            with open("v", "w") as f:
                f.write(v)
            
            m_out = subprocess.run(self.decrypt, capture_output=True).stdout.strip().decode("utf-8")
                    
            if(m_in != m_out):
                print("Results mismatch:")
                print(f"Getting  m {m_out}")
                print(f"Computed m {m_in}")
            else:
                print("Board-side and Host side results match!")
                m_out = [m_out[i:i+2] for i in range(0, len(m_out), 2)]
                for j in range(16):
                    checked_plaintexts[i][j] = int(m_out[j], 16)

            self.recv(5)    # DONE

        return
    
    # This method sends the input to the board, waits for the results and checks
    # it. 
    # The expected HQC outputs are computed by a standalone binary 
    # It fills processed_data with the processed inputs
    def process_input_and_check_dec(self, u, v, m_in, plaintext_size, checked_plaintexts):
        for i in range(0, self.batch_size):
            # send ciphertext
            self.send(bytes.fromhex(u))
            self.send(bytes.fromhex(v))
            
            # receive decrypted message
            m_out = self.recv(plaintext_size*2+1).strip().decode("utf-8")

            if(m_in != m_out):
                print("Results mismatch:")
                print(f"Getting  m {m_out}")
                print(f"Computed m {m_in}")
            else:
                print("Board-side and Host side results match!")
                m_out = [m_out[i:i+2] for i in range(0, len(m_out), 2)]
                for j in range(16):
                    checked_plaintexts[i][j] = int(m_out[j], 16)

            self.recv(5)    # DONE

        return
        
    def send(self,data):
        written = self.uart.write(data)
        self.uart.flush()
        return written

    def recv(self,amount):
        return self.uart.read(amount)
