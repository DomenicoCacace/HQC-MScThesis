import numpy as np
import matplotlib.pyplot as plotter

# Plots first n traces, default 3, in the time domain. Useful to check
# timewise alignment at a glance
def plot_first_n_traces(traces,n=5,Fsample=1,comment=""):
    fig,axes = plotter.subplots()
    samp_period = 1/Fsample
    x = np.linspace(0,traces.shape[1]*samp_period,num=traces.shape[1])
    for i in range(n):
        axes.plot(x,traces[i], linewidth=1)
    axes.set(xlabel=f'Samples at {Fsample} MHz', ylabel='ADC ticks',
       title=f'First {n} traces in time'+comment)    
    plotter.show()
    return

# Plots time-wise average and standard deviations of the first n (default 30)
# traces of the set being passed. Useful to check if spikes in std dev coincide
# with relevant computation points
def plot_avg_stddev_ntraces(traces,n=30,Fsample=1,comment=""):
    mean_to_plot = np.mean(traces[0:n][:],axis=0);
    stddev_to_plot = np.std(traces[0:n][:],axis=0);

    fig,axes = plotter.subplots()
    samp_period = 1/Fsample
    x = np.linspace(0,traces.shape[1]*samp_period,num=traces.shape[1])
    axes.plot(x,mean_to_plot,linewidth=1)
    axes.plot(x, stddev_to_plot, color='lightgreen', linewidth=1)
    axes.set(xlabel=f'Samples at {Fsample} MHz'+comment, ylabel='ADC ticks',
       title=f'Mean (blue) and std. dev. of the first {n} traces'+comment)     
    plotter.show()
    return


def plot_spectrogram(trace, Fsample, windowing=128):
    samp_period = 1/Fsample
    x = np.linspace(0,trace.size*samp_period,num=trace.size)

    fig, (ax1, ax2) = plotter.subplots(nrows=2)
    ax1.plot(x, trace)
    # The `specgram` method returns 4 objects. They are:
    # - Pxx: the periodogram
    # - freqs: the frequency vector
    # - bins: the centers of the time bins
    # - im: the .image.AxesImage instance representing the data in the plot
    Pxx, freqs, bins, im = ax2.specgram(trace,
                                        NFFT=windowing, Fs=Fsample, noverlap=windowing-1)
    plotter.show()
    return

def plot_xcorrelate(trace_a,trace_b):
    xcorr = np.convolve(trace_a,trace_b)
    fig,axes = plotter.subplots()
    x = np.linspace(0,1,xcorr.shape[0])
    axes.plot(x,xcorr,linewidth=1)
    plotter.show()
    return

# receives a num_key_hypothesis x num_samples+1 matrix, where the first column
# contains the value of the key hypotesis, and the remaining ones the sample 
# correlation coefficients as a function of time
def plot_CPA_results_timewise(cpa_results_matrix, correct_key_val = None):
    fig,axes = plotter.subplots()
    x_axis = cpa_results_matrix[:,0]
    axes.set(xlabel=f'Samples', 
             ylabel='Sample r value',
             title=f'Sample correlation coefficient as a function of time') 
    if(correct_key_val != None):
        for key_hp in range(cpa_results_matrix.shape[1]-1):
           if(key_hp == correct_key_val):
               continue #plot the correct key as the last one so that it's visible
           else:
               axes.plot(x_axis,cpa_results_matrix[:,key_hp+1], linewidth=1,color = '0.7')
        axes.plot(x_axis,cpa_results_matrix[:,correct_key_val+1], linewidth=1,color = 'r')
    else:
        for key_hp in range(cpa_results_matrix.shape[1]-1):
               axes.plot(x_axis,cpa_results_matrix[:,key_hp+1], linewidth=1)
    plotter.show()

# receives a num_employed traces x num_key_hypothesis+1 matrix, where the first 
# column contains number of traces employed to compute the CPA, and the 
# remaining ones the maximum sample correlation coefficients, over all time instants,
# as a function of the key hypothesis
def plot_CPA_results_incremental(max_corrcoeffs_incremental, correct_key_val = None):
    fig,axes = plotter.subplots()
    x_axis = max_corrcoeffs_incremental[:,0]
    axes.set(xlabel=f'Number of traces employed to compute r', 
             ylabel='Sample r value',
             title=f'Sample correlation coefficient as a function of the number of traces') 
    if(correct_key_val != None):
        for key_hp in range(max_corrcoeffs_incremental.shape[1]-1):
           if(key_hp == correct_key_val):
               continue #plot the correct key as the last one so that it's visible
           else:
               axes.plot(x_axis,max_corrcoeffs_incremental[:,1+key_hp], linewidth=1,color = '0.7')
        axes.plot(x_axis,max_corrcoeffs_incremental[:,correct_key_val+1], linewidth=1,color = 'r')
    else:
        for key_hp in range(max_corrcoeffs_incremental.shape[1]-1):
            axes.plot(x_axis,max_corrcoeffs_incremental[:,1+key_hp], linewidth=1)
    plotter.show()
    
# plots the normalized interclass variance as a function of the time
def plot_NICV(NICV):
    x = [i for i in range(len(NICV))]
    fig,axes = plotter.subplots()
    axes.plot(x,NICV, linewidth=1)
    axes.set(xlabel=f'Time (samples)', 
             ylabel='NICV',
             title=f'Normalized Interclass Variance')
    plotter.show()

def plot_SNR(SNR):
    x = [i for i in range(len(SNR))]
    fig,axes = plotter.subplots()
    axes.semilogy(x,SNR, linewidth=1)
    axes.set(xlabel=f'Time (samples)', 
             ylabel='SNR',
             title=f'Signal-to-noise ratio')
    plotter.show()
    
    
