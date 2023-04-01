#!/usr/bin/python3
import numpy as np
from sys import path
from os import system

import data_formats.dat_tracereader as dat_tracereader
from scope.PS5422 import PS5422 
import ctypes
from config import Sampling_config
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
    scope.set_sampling_channel("Channel_A","DC","200mV")
    scope.set_trigger_channel("Channel_B","DC","5V")
    scope.config_trigger(Sampling_config.threshold_in_mV, "Rising")
    total_samples = ctypes.c_int32()
    total_samples = scope.set_timebase_nsamples(Sampling_config.sampling_frequency,
                                                Sampling_config.captures_per_batch)
    print(f"Max available samples in scope buffer {total_samples}")
    print(scope)    
    return scope

def output_csv(data, pathname):
    n = len(data)
    fp = open(pathname,"w+")
    fp.write("time,tstat\n")
    for i in range(n):
        fp.write(str(i) +","+  str(data[i])+"\n")
    fp.close()
    return 


if __name__ == "__main__":
    serial_port_pathname = args.serialport
    # Prepare inputs
    plaintext_size = 16
    ciphertext_size = [2209, 2208]

    if args.algorithm == "enc":
        output_size = ciphertext_size
        samples = 182e6
        pretrig = 0.02
    elif args.algorithm == "dec":
        output_size = plaintext_size
        samples = 100e6
        pretrig = 0.02
    elif args.algorithm == "decode":
        output_size = plaintext_size
        samples = 7.5e6
        pretrig = 0.004
    elif args.algorithm == "decode-rs":
        output_size = plaintext_size
        samples = 1.65e6
        pretrig = 0.0003
    else:
        raise Exception("Unknown algorithm")


    output_pathname = args.output
    
    scope = init_oscilloscope()
    scope.samples_to_capture = int(samples) 
        
    # Prepare memory buffers
    samples_per_capture = scope.prepare_memory(Sampling_config.captures_per_batch)
    samples_per_trace = int(samples)

    traces_in = np.ma.zeros( (Sampling_config.captures_per_batch,samples_per_trace),
                            dtype=np.int16 )
    
    mean_fix = np.ma.zeros( (Sampling_config.captures_per_batch,samples_per_trace),
                        dtype=np.float )

    m2_fix = np.ma.zeros( (Sampling_config.captures_per_batch,samples_per_trace),
                        dtype=np.float )
    
    mean_var = np.ma.zeros( (Sampling_config.captures_per_batch,samples_per_trace),
                        dtype=np.float )

    m2_var = np.ma.zeros( (Sampling_config.captures_per_batch,samples_per_trace),
                        dtype=np.float )

    # Initialize board
    board_serial = "303637324646353335373532383737"
    myboard = nucleo_HQC(Sampling_config.captures_per_batch, args.exec_folder, mode=args.algorithm)

    # Initialize communication
    myboard.init_serial(args.serialport)
    

    myboard.reset_board(board_serial)

    myboard.exchange_keys()
    inputs = myboard.generate_inputs()
        
    num_traces = Sampling_config.batches_to_capture

    print("Variable inputs - start")
    # Run the actual capture - variable inputs
    for batch_id in range(num_traces):
        inputs = myboard.generate_inputs()
        print(f" * Capturing batch {batch_id+1}/{num_traces}")
        # Start capture
        scope.capture(samples_per_capture, pre_trigger_sample_ratio=pretrig)
        
        # Run the algorithm
        myboard.process_input_and_check(inputs, output_size)
        
        # Fetch the traces from the oscilloscope buffer, into the traces buffer 
        scope.get_traces(traces_in)

        # remove average
        m = np.average(traces_in)
        traces_in = traces_in - m
        # update rolling mean and m2
        delta = traces_in - mean_var
        mean_var += delta / (batch_id + 1)
        delta2 = traces_in - mean_var
        m2_var += delta * delta2
    

    # Store traces to file
    outfile = dat_tracereader.dat_tracereader()
    outfile.create(f"{output_pathname}_var_mean", samples_per_capture, 'f')
    outfile.write_traces(mean_var)
    outfile.close()

    m2_var = (m2_var / (num_traces - 1))
    outfile = dat_tracereader.dat_tracereader()
    outfile.create(f"{output_pathname}_var_m2", samples_per_capture, 'f')
    outfile.write_traces(m2_var)
    outfile.close()
    print("Variable inputs - done")

    print("\n Fixed inputs - start")
    # Run the actual capture - fixed inputs
    inputs = myboard.generate_inputs()
    for batch_id in range(num_traces):
        print(f" * Capturing batch {batch_id+1}/{num_traces}")
        # Start capture
        scope.capture(samples_per_capture, pre_trigger_sample_ratio=pretrig)

        # Run the algorithm
        myboard.process_input_and_check(inputs, output_size)
        
        # Fetch the traces from the oscilloscope buffer, into the traces buffer 
        scope.get_traces(traces_in)

        # remove average
        m = np.average(traces_in)
        traces_in = traces_in - m
        # update rolling mean and m2
        delta = traces_in - mean_fix
        mean_fix += (delta / (batch_id + 1))
        delta2 = traces_in - mean_fix
        m2_fix += (delta * delta2)
    
    
    # Store traces to file
    outfile = dat_tracereader.dat_tracereader()
    outfile.create(f"{output_pathname}_fix_mean", samples_per_capture, 'f')
    outfile.write_traces(mean_fix)
    outfile.close()

    m2_fix = (m2_fix / (num_traces - 1))
    outfile = dat_tracereader.dat_tracereader()
    outfile.create(f"{output_pathname}_fix_m2", samples_per_capture, 'f')
    outfile.write_traces(m2_fix)
    outfile.close()
    print("Fixed inputs - done")

    tstat = mean_var - mean_fix
    
    print("Calculating tstat...")
    # den: sqrt(var_fixed/n + var_m2iable/n)
    tstat = tstat / np.sqrt((m2_var + m2_fix)/num_traces)
    print("Done!\n")

    print("Dumping data to file...")
    file = dat_tracereader.dat_tracereader()
    file.create(f"{output_pathname}_tstat.npy", samples_per_capture, 'f')
    file.write_traces(tstat)
    file.close()
    print("Done!\n")

    #print("Saving csv file...")
    #output_csv(tstat[0], f"{output_pathname}_tstat.csv")
    #print("Done!")

    # Remove files
    myboard.remove_files()
