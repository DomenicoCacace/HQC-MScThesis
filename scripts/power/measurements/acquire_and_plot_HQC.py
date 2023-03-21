#!/usr/bin/python3
import numpy as np
from scope.PS5422 import PS5422 
from board.nucleo_HQC import nucleo_HQC
import ctypes
from config import FreeSCA_config,Sampling_config
import argparse

from trace_visualization import plot_first_n_traces,plot_avg_stddev_ntraces,plot_spectrogram

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
    scope.set_sampling_channel("Channel_A","DC","500mV")
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
    else:
        output_size = plaintext_size

    output_pathname = args.output
    
    scope = init_oscilloscope() 
        
    # Prepare memory buffers
    samples_per_capture = scope.prepare_memory(Sampling_config.captures_per_batch)
    if (scope.trigger_channel == "Channel_B"):
        samples_per_trace = samples_per_capture//2
    else:
        samples_per_trace = samples_per_capture
    
    traces = np.ma.zeros( (Sampling_config.captures_per_batch,
                           samples_per_trace),
                           dtype=np.int16 )
    traces_avg = np.ma.zeros( (Sampling_config.captures_per_batch,
                               samples_per_trace),
                               dtype=np.float )
    checked_plaintexts = np.ma.zeros( (Sampling_config.captures_per_batch,
                                       plaintext_size),
                                       dtype=FreeSCA_config.default_input_byte_type )

    # prepare board
    myboard = nucleo_HQC(Sampling_config.captures_per_batch, args.exec_folder, mode=args.algorithm)
    board_serial_no = "303637324646353335373532383737"
    #print(f"Programming board with {bitstream}")
    myboard.reset_board(board_serial_no)
    myboard.init_serial(serial_port_pathname)
    
    myboard.exchange_keys()
    inputs = myboard.generate_inputs(Sampling_config.captures_per_batch, fixed=args.fixed)

    # Run the actual capture
    for batch_id in range(Sampling_config.batches_to_capture):
        if not args.fixed:
            inputs = myboard.generate_inputs(Sampling_config.captures_per_batch, fixed=args.fixed)
        for i in range(Sampling_config.num_repetitions_to_average):
            print(f" * Capturing repetition no. {i+1}/{Sampling_config.num_repetitions_to_average} of batch {batch_id}/{Sampling_config.batches_to_capture}")
            scope.capture(samples_per_capture)
        
            myboard.process_input_and_check(inputs, output_size, checked_plaintexts)
            
            # Fetch the traces from the oscilloscope buffer, into the traces buffer 
            scope.get_traces(traces)
            traces_avg += traces.astype(np.float)

        traces_avg /= Sampling_config.num_repetitions_to_average


    #plot outcome of the captures to check
    plot_first_n_traces(traces_avg,Fsample=Sampling_config.sampling_frequency,n=1)
    plot_avg_stddev_ntraces(traces_avg,n=1)
    #plot_spectrogram(traces_avg[0],Sampling_config.sampling_frequency)

    # Remove files
    myboard.remove_files()
