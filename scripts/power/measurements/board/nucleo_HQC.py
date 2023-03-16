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

    def process_input_and_check(self, checked_inputs, output_size, fixed_inputs):
        if self.mode == "enc":
            self.process_input_and_check_enc(checked_inputs, output_size, fixed_inputs)
        else:
            self.process_input_and_check_dec(checked_inputs, output_size, fixed_inputs)

        return
    
    # This method sends the input to the board, waits for the results and checks
    # it. 
    # The expected HQC outputs are computed by a standalone binary 
    # It fills processed_data with the processed inputs
    def process_input_and_check_enc(self, checked_plaintexts, ciphertext_size, fixed_inputs):
        # generate keypair
        print("Generate keypair...")
        keys = subprocess.run(self.keygen, capture_output=True).stdout.strip().decode("utf-8").split('\n')
        pk = keys[0]
        sk = keys[1]
        #print("pk: ", pk)
        #print("sk: ", sk)
        print("Done!\n")
            

        # init comm
        self.send(b"RDY\n")
        ok = self.recv(3)
            
        # send keypair
        self.send(bytes.fromhex(pk))
        self.send(bytes.fromhex(sk))
        
        # generate message - fixed
        m_in = subprocess.check_output(["xxd", "-l", "16", "-p", "/dev/urandom"]).decode("utf-8").strip()

        for i in range(self.batch_size):
            print(f"Round {i}")
            # generate message
            if not fixed_inputs:
                m_in = subprocess.check_output(["xxd", "-l", "16", "-p", "/dev/urandom"]).decode("utf-8").strip()
                #print("m: ", m_in)

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
            with open("sk", "w") as f:
                f.write(sk)
            
            m_out = subprocess.run(self.decrypt, capture_output=True).stdout.strip().decode("utf-8")
        
            # remove files
            system("rm u")
            system("rm v")
            system("rm sk")
            
            if(m_in != m_out):
                print("Results mismatch:")
                print(f"Getting  m {m_out}")
                print(f"Computed m {m_in}")
            else:
                print("Board-side and Host side results match!")
                #checked_plaintexts[i] = m_out
                # TODO: enable?

            self.recv(5)    # DONE

        return
    
    # This method sends the input to the board, waits for the results and checks
    # it. 
    # The expected HQC outputs are computed by a standalone binary 
    # It fills processed_data with the processed inputs
    def process_input_and_check_dec(self, checked_plaintexts, plaintext_size, fixed_inputs):
        # generate keypair
        print("Generate keypair...")
        keys = subprocess.run(self.keygen, capture_output=True).stdout.strip().decode("utf-8").split('\n')
        pk = keys[0]
        sk = keys[1]
        #print("pk: ", pk)
        #print("sk: ", sk)
        print("Done!\n")
            

        # init comm
        self.send(b"RDY\n")
        ok = self.recv(3)
            
        # send keypair
        self.send(bytes.fromhex(pk))
        self.send(bytes.fromhex(sk))

        # generate message - fixed
        m_in = subprocess.check_output(["xxd", "-l", "16", "-p", "/dev/urandom"]).decode("utf-8").strip()
        #print("m: ", m_in)

        # get ciphertext
        with open("m_in", "w") as f:
            f.write(m_in)
        with open("pk", "w") as f:
            f.write(pk)
        ctx = subprocess.run(self.encrypt, capture_output=True).stdout.strip().decode("utf-8").split('\n')
        u = ctx[0]
        v = ctx[1]


        for i in range(self.batch_size):
            print(f"Round {i}")
            # generate message
            if not fixed_inputs:
                m_in = subprocess.check_output(["xxd", "-l", "16", "-p", "/dev/urandom"]).decode("utf-8").strip()
                #print("m: ", m_in)

                # get ciphertext
                with open("m_in", "w") as f:
                    f.write(m_in)
                with open("pk", "w") as f:
                    f.write(pk)
                ctx = subprocess.run(self.encrypt, capture_output=True).stdout.strip().decode("utf-8").split('\n')
                u = ctx[0]
                v = ctx[1]

            # send ciphertext
            self.send(bytes.fromhex(u))
            self.send(bytes.fromhex(v))
            
            # receive decrypted message
            m_out = self.recv(plaintext_size*2+1).strip().decode("utf-8")

            # remove files
            system("rm m_in")
            system("rm pk")

            if(m_in != m_out):
                print("Results mismatch:")
                print(f"Getting  m {m_out}")
                print(f"Computed m {m_in}")
            else:
                print("Board-side and Host side results match!")
                #checked_plaintexts[i] = m_out
                # TODO: enable?


            self.recv(5)    # DONE

        return
        
    def send(self,data):
        written = self.uart.write(data)
        self.uart.flush()
        return written

    def recv(self,amount):
        return self.uart.read(amount)
