#!/usr/bin/python3

from board.nucleo_HQC import nucleo_HQC
import numpy as np
from config import FreeSCA_config,Sampling_config
import argparse

parser = argparse.ArgumentParser(description='Test the configuration')
parser.add_argument("-s", "--serialport", type=str, default="/dev/ttyUSB0", help='serial number of the board')
parser.add_argument("-o", "--output", type=str, default="", required=True, help='Path to the output file')
parser.add_argument("-f", "--fixed", action="store_true", help="Use fixed inputs")
parser.add_argument("-e", "--exec-folder", type=str, default="../", help="path to the directory containing the binaries")
#parser.add_argument("-b", "--batch-size", type=int, default=1000, help="Number of samples to take for each algorithm")
parser.add_argument("-a", "--algorithm", type=str, default="enc", help="Algorithm to run (enc, dec)")
args = parser.parse_args()

# Initialize board
board_serial = "303637324646353335373532383737"
myboard = nucleo_HQC(Sampling_config.captures_per_batch, args.exec_folder, mode=args.algorithm)
myboard.reset_board(board_serial)

# Initialize communication
myboard.init_serial(args.serialport)

# Prepare inputs
plaintext_size = 16
ciphertext_size = [2209, 2208]

if args.algorithm == "enc":
   output_size = ciphertext_size
else:
   output_size = plaintext_size

myboard.exchange_keys()
inputs = myboard.generate_inputs(Sampling_config.captures_per_batch, fixed=args.fixed)

# run the tests
for batch_id in range(Sampling_config.batches_to_capture):
   if not args.fixed:
      inputs = myboard.generate_inputs(Sampling_config.captures_per_batch, fixed=args.fixed)
   for i in range(Sampling_config.num_repetitions_to_average):
      print(f" * Capturing repetition no. {i+1}/{Sampling_config.num_repetitions_to_average} of batch {batch_id}/{Sampling_config.batches_to_capture}")
      # Process data and fill checked_plaintexts with the plaintext sent
      myboard.process_input_and_check(inputs, output_size)

# Remove files
myboard.remove_files()
