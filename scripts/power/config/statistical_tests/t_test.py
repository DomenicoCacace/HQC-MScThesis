# Implementation of Welch's t-test

import numpy as np

class t_test:
    def __init__(self,trace_samples):
        self.mean_first_traceset = np.zeros([trace_samples])
        self.m2_first_traceset = np.zeros([trace_samples])
        self.num_first_traces_added = 0
        self.mean_second_traceset = np.zeros([trace_samples])
        self.m2_second_traceset = np.zeros([trace_samples])
        self.num_second_traces_added = 0  
        self.trace_samples = trace_samples
        self.result_valid = False
        self.tstatistic = np.zeros([trace_samples])
        return
    
    def __repr__(self):
        return ( "t-test with tracelen " +
                 str(self.trace_samples) +
                 ". Added (" + str(self.num_first_traces_added) + "," + 
                 str(self.num_second_traces_added) + ") traces.")
                 
    # traces are one trace per row of traces, predictions one per row of predictions
    def add_data(self,traces,set_label):
        if (set_label not in [0,1]):
            print("Admissible set labels to add data to a t-test are in \{0,1\}")
            return
        delta = np.zeros([self.trace_samples])
        delta2 = np.zeros([self.trace_samples])
        if (set_label == 0):
            for i in range(traces.shape[0]):
                self.num_first_traces_added += 1
                delta = traces[i] - self.mean_first_traceset
                self.mean_first_traceset += delta / self.num_first_traces_added
                delta2 = traces[i] - self.mean_first_traceset
                self.m2_first_traceset += delta*delta2
        else:
            for i in range(traces.shape[0]):
                self.num_second_traces_added += 1
                delta = traces[i] - self.mean_second_traceset
                self.mean_second_traceset += delta / self.num_second_traces_added
                delta2 = traces[i] - self.mean_second_traceset
                self.m2_second_traceset += delta*delta2            
        print(traces.shape[0],traces.shape[1],self.mean_first_traceset,self.mean_second_traceset)        
        return
 
    # returns vector of t-statistics, one for each time instant
    def compute_t(self):
        if ((self.num_first_traces_added < 2) or 
            (self.num_second_traces_added < 2)):
            print("Less than two traces for at least one population.")
            return np.zeros([trace_samples])
        #start by finalizing sample variance estimates
        var_first = self.m2_first_traceset / (self.num_first_traces_added-1)
        var_second = self.m2_second_traceset / (self.num_second_traces_added-1)
        self.tstatistic = self.mean_first_traceset - self.mean_second_traceset
        self.tstatistic = self.tstatistic / np.sqrt( var_first/self.num_first_traces_added + 
                             var_second/self.num_second_traces_added)
        self.result_valid = True
        return self.tstatistic

    def output_csv_result(self,pathname):
        fp = open(pathname,"w+")
        fp.write("time,tstat\n")
        for i in range(self.trace_samples):
           fp.write(str(i) +","+  str(self.tstatistic[i])+"\n")
        fp.close()
        return 

