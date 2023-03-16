#!/usr/bin/python3

import data_formats.dat_tracereader as dat_tracereader
import data_formats.hdf5_tracereader as hdf5_tracereader
import numpy as np

import argparse
import trace_visualization

from statistical_tests.t_test import t_test
import matplotlib.pyplot as plotter

parser = argparse.ArgumentParser(description='Run a t-test on two sets of traces')
parser.add_argument("-b", "--batch-size", type=int, default=1000, help="Number of samples to take for each algorithm")
parser.add_argument("-t", "--trim-head", type=int, default=0, help="Number of samples to trim from the head of the trace")
parser.add_argument("-T", "--trim-tail", type=int, default=0, help="Number of samples to trim from the tail of the trace")
parser.add_argument("-n", "--num-batches", type=int, default=1, help="Number of batches to process")
parser.add_argument("--in1", type=str, default="", required=True, help='Path to the first input file')
parser.add_argument("--in2", type=str, default="", required=True, help='Path to the second input file')
parser.add_argument("-o", "--out", type=str, default="", help='Path to the output file')
args = parser.parse_args()

trim_head = args.trim_head
trim_tail = args.trim_tail

batch_size = args.batch_size
num_batches = args.num_batches

#num_key_bits = 8
#num_key_hp =  2**num_key_bits
#byte_to_attack = 1


def Hamming_weight(num: int) -> int:
    weight = 0
    while num:
        weight += 1
        num &= num - 1
    return weight

def remove_mean(traces):
    for i in range(traces.shape[0]):
        m = np.average(traces[i])
        traces[i] = traces[i] - m
    return


if __name__ == "__main__":    
    split_filename = args.in1.split('.') 
    if ( (split_filename[-1] == "hdf5") or 
         (split_filename[-1] == "h5")):
        first_tracefile = hdf5_tracereader.hdf5_tracereader()
    else:
        first_tracefile = dat_tracereader.dat_tracereader()  
    first_tracefile.open(args.in1)
    print(first_tracefile)

    split_filename = args.in2.split('.') 
    if ( (split_filename[-1] == "hdf5") or 
         (split_filename[-1] == "h5")):
        second_tracefile = hdf5_tracereader.hdf5_tracereader()
    else:
        second_tracefile = dat_tracereader.dat_tracereader()  
    second_tracefile.open(args.in2)
    print(second_tracefile)    
    
    #trace_visualization.plot_first_n_traces(traces)
    #trace_visualization.plot_avg_stddev_ntraces(traces)
    #trace_visualization.plot_spectrogram(traces[0], 2.5*10e8, windowing=1024)
    #trace_visualization.plot_xcorrelate(traces[0],traces[1])
    ##################################

    # if tracesets have different length, print warning and trim ttest to shortest
    if (first_tracefile.trace_len != second_tracefile.trace_len):
       print("Warning: tracesets differ in size. Trimming test to shortest one")
    if (first_tracefile.trace_len > second_tracefile.trace_len):
       delta = first_tracefile.trace_len - second_tracefile.trace_len
       trim_tail1 = trim_tail+delta
       trim_tail2 = trim_tail
    else:
       delta = second_tracefile.trace_len - first_tracefile.trace_len    
       trim_tail1 = trim_tail
       trim_tail2 = trim_tail+delta

    trimmed_trace_len = first_tracefile.trace_len - trim_tail1        
    my_ttest = t_test(trimmed_trace_len)
    print(f"Initialized t-test: {my_ttest}")  
    for i in range(num_batches):
        print(f"Processing batch {i} out of {num_batches}")
        #read inputs from file, trimming traces and discarding plaintexts
        print(" - Reading traceset 0")
        traces,_ = first_tracefile.read_traces(batch_size,trim_head,trim_tail1)
        remove_mean(traces)
        my_ttest.add_data(traces,0)
        print(" - Reading traceset 1")
        traces,_ = second_tracefile.read_traces(batch_size,trim_head,trim_tail2)
        remove_mean(traces)
        my_ttest.add_data(traces,1)
        print(my_ttest)
        
    tstatistic= my_ttest.compute_t()
    print("done computing")
    if (args.out == ""):  
        output_csv_name = input("Results pathname?: ")
        my_ttest.output_csv_result(output_csv_name)
        fig,axes = plotter.subplots()
        x = [i for i in range(trimmed_trace_len)]
        axes.plot(x,tstatistic[:], linewidth=1)
        plotter.show()
    else:
        my_ttest.output_csv_result(args.out)
        fig,axes = plotter.subplots()
        x = [i for i in range(trimmed_trace_len)]
        axes.plot(x,tstatistic[:], linewidth=1)
        fig.savefig(args.out+".png", dpi=300)
