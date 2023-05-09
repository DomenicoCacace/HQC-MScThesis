import numpy as np
import matplotlib.pyplot as plotter
from config.data_formats import dat_tracereader
import argparse

def main():
    parser = argparse.ArgumentParser(description='Plot traces')
    parser.add_argument('-i', '--input', type=str, help='Path to trace file')
    parser.add_argument('-o', '--output', type=str, default="./plot", help='Path to output file')
    parser.add_argument('-c', '--caption', type=str, default="", help='Caption for the plot')
    parser.add_argument('-t', '--transparent', action='store_true', help='Make background transparent')
    parser.add_argument('-v', '--variation', action='store_true', help='Plot variation')
    args = parser.parse_args()

    trace = load(args.input)
    if args.variation:
        plot_variation(trace, args.output, args.caption, args.transparent)
    else:
        plot(trace, args.output, args.caption, args.transparent)
    return

def load(path):
    tracefile = dat_tracereader.dat_tracereader()
    tracefile.open(path)
    return tracefile.read_traces(1)

def plot(trace, out, caption="", transparent=False):
    n=1
    chunk_size = 100000
    nchunks = int(trace.shape[1]/chunk_size)
    fig,axes = plotter.subplots(figsize=(8,2))
    samp_period = 1/500e6
    x = np.linspace(0,trace.shape[1]/1000,num=trace.shape[1])
    # define color with rgb
    color = (92/255, 138/255, 153/255)
    for j in range(n):
        for i in range(nchunks):
            axes.plot(x[i*chunk_size:(i+1)*chunk_size],trace[0][i*chunk_size:(i+1)*chunk_size], linewidth=0.09, color=color)
    axes.axhline(y=4.5, linestyle='--', color='red', linewidth=0.8)
    axes.axhline(y=-4.5, linestyle='--', color='red', linewidth=0.8)
    #axes.set(xlabel=f'sample number (x1000)', ylabel='t-value',
    #   title=caption)    
    #plotter.show()
    axes.set(xlim=(0, trace.shape[1]/1000))
    plotter.savefig(f"{out}", dpi=300, transparent=transparent)
    return

def plot_variation(trace, out, caption="", transparent=False):
    trace = trace[:,10:]
    color = (92/255, 138/255, 153/255)
    fig,axes = plotter.subplots(figsize=(8,2))
    #axes.set_yscale('log')
    x = np.linspace(1,trace.shape[1], num=trace.shape[1])
    axes.plot(x,trace[0], linewidth=1, color=color)
    axes.axhline(y=4.5, linestyle='--', color='red', linewidth=0.8)
    plotter.savefig(f"{out}", dpi=300, transparent=transparent)
    return


if __name__ == "__main__":
    main()
