
class Scope:
    def __init__(self):
        self.sampling_frequency = 0
        self.sampling_channel = 0
        self.trigger_channel = 0
        self.voltage_range = " 2V"
        
    def __repr__(self):
        pretty_printed = "Sample oscilloscope"
        pretty_printed += f"Sampling frequency {self.sampling_frequency}"
        pretty_printed += f"Sampling channel {self.sampling_channel}"
        pretty_printed += f"Sampling voltage range {self.voltage_range}"
                
