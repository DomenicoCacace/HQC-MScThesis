import numpy as np

class FreeSCA_config:
    # type for upcasting samples before processing
    default_sample_type=np.double
    # signed or unsigned characters?
    default_input_byte_type=np.int8
    # should plots be enabled for non-inspection scripts?
    default_plotting_enabled = True
    
class Sampling_config:
    batches_to_capture = 50
    captures_per_batch = 1
    threshold_in_mV = 250
    sampling_frequency = 500e6
    num_repetitions_to_average = 1

    
