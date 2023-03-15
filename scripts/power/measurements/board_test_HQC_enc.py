#!/usr/bin/python3

from board.nucleo_HQC import nucleo_HQC
import numpy as np
from config import FreeSCA_config,Sampling_config
import argparse

parser = argparse.ArgumentParser(description='Test the board')
parser.add_argument('--serial', type=str, default="/dev/ttyUSB0", help='serial number of the board')
parser.add_argument("--exec-folder", type=str, default="./", help="path to the directory containing the binaries")

args = parser.parse_args()

# Initialize board
board_serial = "303637324646353335373532383737"
myboard = nucleo_HQC(Sampling_config.captures_per_batch, args.exec_folder, mode="enc")
myboard.reset_board(board_serial)

# Initialize communication
myboard.init_serial(args.serial)

# Prepare inputs
plaintext_size = 16
ciphertext_size = [2209, 2208]

for i in range(Sampling_config.num_repetitions_to_average):
   # Prepare room for outputs
   checked_plaintexts = np.ma.zeros( (Sampling_config.captures_per_batch,
                                      plaintext_size),
                                      dtype=FreeSCA_config.default_input_byte_type )
   
   # Process data and fill checked_plaintexts with the plaintext sent
   myboard.process_input_and_check(checked_plaintexts, ciphertext_size)

   plaintext = bytes(checked_plaintexts[-1])
