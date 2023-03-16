import numpy as np

class FreeSCA_config:
    # type for upcasting samples before processing
    default_sample_type=np.double
    # signed or unsigned characters?
    default_input_byte_type=np.int8
    # should plots be enabled for non-inspection scripts?
    default_plotting_enabled = True
    
class TA_config:
    template_label_list= ['00','FF']
