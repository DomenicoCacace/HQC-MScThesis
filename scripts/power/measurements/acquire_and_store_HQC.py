#!/usr/bin/python3
import numpy as np
from scope.PS5422 import PS5422 
import ctypes
from config import FreeSCA_config,Sampling_config
from board.nucleo_HQC import nucleo_HQC
import argparse

import data_formats.dat_tracereader as dat_tracereader

parser = argparse.ArgumentParser(description='Test the configuration')
parser.add_argument("-s", "--serialport", type=str, default="/dev/ttyUSB0", help='serial number of the board')
parser.add_argument("-o", "--output", type=str, default="", required=True, help='Path to the output file')
parser.add_argument("-f", "--fixed", action="store_true", help="Use fixed inputs")
parser.add_argument("-e", "--exec-folder", type=str, default="../", help="path to the directory containing the binaries")
#parser.add_argument("-b", "--batch-size", type=int, default=1000, help="Number of samples to take for each algorithm")
parser.add_argument("-a", "--algorithm", type=str, default="enc", help="Algorithm to run (enc, dec)")
args = parser.parse_args()


def init_oscilloscope():
    scope = PS5422()
    scope.set_sampling_channel("Channel_A","DC","1V")
    scope.set_trigger_channel("Channel_B","DC","5V")
    scope.config_trigger(Sampling_config.threshold_in_mV, "Rising")
    total_samples = ctypes.c_int32()
    total_samples = scope.set_timebase_nsamples(Sampling_config.sampling_frequency,
                                                Sampling_config.captures_per_batch)
    print(f"Max available samples in scope buffer {total_samples}")
    print(scope)    
    return scope


if __name__ == "__main__":
    serial_port_pathname = args.serialport
    # Prepare inputs
    plaintext_size = 16
    ciphertext_size = [2209, 2208]
    if args.algorithm == "enc":
        output_size = ciphertext_size
        samples = 182e6
    else:
        output_size = plaintext_size
        samples = 100e6

    output_pathname = args.output
    
    scope = init_oscilloscope()
    scope.samples_to_capture = int(samples) 
        
    # Prepare memory buffers
    samples_per_capture = scope.prepare_memory(Sampling_config.captures_per_batch)
    samples_per_trace = int(samples)
    traces = np.ma.zeros( (Sampling_config.captures_per_batch,samples_per_trace),
                          dtype=np.int16 )

    # Initialize board
    board_serial = "303637324646353335373532383737"
    myboard = nucleo_HQC(Sampling_config.captures_per_batch, args.exec_folder, mode=args.algorithm)
    myboard.reset_board(board_serial)

    # Initialize communication
    myboard.init_serial(args.serialport)
    
    # open file for trace storage
    outfile = dat_tracereader.dat_tracereader()
    if (Sampling_config.num_repetitions_to_average == 1):
        outfile.create(output_pathname, samples_per_capture, 'h')
    else:
        outfile.create(output_pathname, samples_per_capture, 'f')

    myboard.exchange_keys()
    inputs = myboard.generate_inputs(Sampling_config.captures_per_batch, fixed=args.fixed)
        
    # Run the actual capture
    for batch_id in range(Sampling_config.batches_to_capture):
        if not args.fixed:
            inputs = myboard.generate_inputs(Sampling_config.captures_per_batch, fixed=args.fixed)
        print(f" * Capturing batch {batch_id+1}/{Sampling_config.batches_to_capture}")
        # Start capture
        scope.capture(samples_per_capture, pre_trigger_sample_ratio=0.02)
        
        # Run the algorithm
        myboard.process_input_and_check(inputs, output_size)
        
        # Fetch the traces from the oscilloscope buffer, into the traces buffer 
        scope.get_traces(traces)

        # Write the traces to the file
        outfile.write_traces(traces)

    print(outfile)
    outfile.close()
    # Remove files
    myboard.remove_files()
