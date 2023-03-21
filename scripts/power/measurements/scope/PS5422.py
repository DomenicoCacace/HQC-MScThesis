import ctypes

from picosdk.ps5000a import ps5000a
from picosdk.functions import adc2mV, assert_pico_ok, mV2adc

from scope.scope import Scope
import numpy as np

ps5000a_couplings = {"DC" : ps5000a.PS5000A_COUPLING["PS5000A_DC"],
                     "AC" : ps5000a.PS5000A_COUPLING["PS5000A_AC"]}
ps5000a_ranges = {
    "10mV" : ps5000a.PS5000A_RANGE["PS5000A_10MV" ],
    "20mV" : ps5000a.PS5000A_RANGE["PS5000A_20MV" ],
    "50mV" : ps5000a.PS5000A_RANGE["PS5000A_50MV" ],
    "100mV": ps5000a.PS5000A_RANGE["PS5000A_100MV"],
    "200mV": ps5000a.PS5000A_RANGE["PS5000A_200MV"],
    "500mV": ps5000a.PS5000A_RANGE["PS5000A_500MV"],
      "1V" : ps5000a.PS5000A_RANGE["PS5000A_1V"   ],
      "2V" : ps5000a.PS5000A_RANGE["PS5000A_2V"   ],
      "5V" : ps5000a.PS5000A_RANGE["PS5000A_5V"], 
     "10V" : ps5000a.PS5000A_RANGE["PS5000A_10V"   ]}

ps5000a_channels = {"Channel_A": ps5000a.PS5000A_CHANNEL["PS5000A_CHANNEL_A"],
                    "Channel_B": ps5000a.PS5000A_CHANNEL["PS5000A_CHANNEL_B"]}
ps5000a_trigger_dir = {"Rising": ps5000a.PS5000A_THRESHOLD_DIRECTION["PS5000A_RISING"]}

class PS5422(Scope):
    def __init__(self):
        self.sampling_frequency = "Not set"
        self.sampling_channel = "Not set"
        self.sampling_range = "Not set"
        self.trigger_channel = "Not set"
        self.trigger_range = "Not set"
        self.vert_resolution = "Not set"
        self.samples_to_capture = 0
        self.scope_handle = ctypes.c_int16(0)
        # size of the scope buffer, in bytes
        self.buffer_size = 512*1024*1024
        # list of buffers to copy the results
        self.buffer_list = []
        self.start_unit()
        
    def __del__(self):
        self.stop_unit()
        #self.close_handle()
        pass
        
    def __repr__(self):
        pretty_printed = "Picoscope 5422D\n"
        pretty_printed += f"Sampling frequency {self.sampling_frequency}\n"
        pretty_printed += f"Sampling channel {self.sampling_channel}\n"
        pretty_printed += f"Sampling voltage range {self.sampling_range}\n"
        pretty_printed += f"Trigger channel {self.trigger_channel}\n"
        pretty_printed += f"Trigger range {self.trigger_range}\n"
        return pretty_printed
    
    def start_unit(self):
        print("Initializing Scope")
        resolution = ps5000a.PS5000A_DEVICE_RESOLUTION["PS5000A_DR_8BIT"]
        retval = ps5000a.ps5000aOpenUnit(ctypes.byref(self.scope_handle), 
                                         None, 
                                         resolution)
        try:
            assert_pico_ok(retval)
        except:
            if retval == 286:
                status = ps5000a.ps5000aChangePowerSource(self.scope_handle, retval)
            elif retval == 282:
                status = ps5000a.ps5000aChangePowerSource(self.scope_handle, retval)
            else:
                raise        
        self.vert_resolution = "8 bit"
        print(self.scope_handle)
        
    def stop_unit(self):
        print("Stopping Scope")
        retval = ps5000a.ps5000aStop(self.scope_handle)
        assert_pico_ok(retval)

    def close_handle(self):
        print("Stopping Scope")
        retval = ps5000a.ps5000aCloseUnit(self.scope_handle)
        assert_pico_ok(retval)


    # Sets sampling channel, defaults to channel A, DC coupling, +/- 2V
    def set_sampling_channel(self, 
                             chan = "Channel_A",
                             coupling = "DC",
                             chan_range = "5V"):
        print(f"range: {chan_range}")
        enable_channel = 1
        #analog offset in volts
        analog_offset = 0.0
       
        status = ps5000a.ps5000aSetChannel(self.scope_handle, 
                                     ps5000a_channels[chan], 
                                     enable_channel, 
                                     ps5000a_couplings[coupling], 
                                     ps5000a_ranges[chan_range], 
                                     analog_offset)
        assert_pico_ok(status)        
        self.sampling_channel = chan
        self.sampling_range = chan_range

    # Sets trigger channel, defaults to channel B, DC coupling, +/- 5V
    def set_trigger_channel(self, 
                            chan = "Channel_B",
                            coupling = "DC",
                            chan_range = "5V" ):
        enable_channel = 1
        analog_offset = 0.0
        status = ps5000a.ps5000aSetChannel(self.scope_handle, 
                                     ps5000a_channels[chan], 
                                     enable_channel, 
                                     ps5000a_couplings[coupling], 
                                     ps5000a_ranges[chan_range], 
                                     analog_offset)
        assert_pico_ok(status)        
        self.trigger_channel = chan
        self.trigger_range = chan_range


    # Configures the trigger, defaults to channel B, 750 mV, rising, no delay
    # trigger threshold in mV
    def config_trigger(self,
                       threshold = 750,
                       direction = "Rising"):
        
        maxADC = ctypes.c_int16()
        ps5000a.ps5000aMaximumValue(self.scope_handle, ctypes.byref(maxADC))
        #convert threshold to ADC value
        adcthreshold = int(mV2adc(threshold,ps5000a_ranges[self.trigger_range], maxADC))
        enable_channel = 1
        delay = 0
        autotrigger_after_ms = 1000
        status = ps5000a.ps5000aSetSimpleTrigger(self.scope_handle,
                                           enable_channel, 
                                           ps5000a_channels[self.trigger_channel], 
                                           adcthreshold, 
                                           ps5000a_trigger_dir[direction], 
                                           delay, 
                                           autotrigger_after_ms)
                                           
        assert_pico_ok(status)
        self.trigger_threshold = threshold
        self.trigger_direction = direction
        return

    # This method converts the desired sampling frequency into
    # the closest timebase value for the picoscope
    # The conversion criterion makes it so that the frequency is never
    # set below the desired one.
    # it returns a pair of values: the timebase value to be used in the 
    # scope configuration and the actual closest (rounding up) frequency 
    # available
    def frequency_to_timebase(self,freq):
        if (freq >=250e6):
            for timebase in range(3):
                if (1e09/2**timebase >= freq) and (1e09/2**(timebase+1) < freq):
                    return timebase,(1e09/2**timebase)
        elif (freq < 250e6) and (freq > 125e6):
            return 2,250e6    
        else:
            for timebase in range(3,100):
                if (125e06/(timebase-2) >= freq) and (125e06/(timebase-1) < freq):
                    return timebase, (125e06/(timebase-2))
        return 101,(125e06/(101-2))

    # Sets the sampling frequency and the desired number of captures per batch
    # Since it's the scope library determining the actual number of samples, 
    # return actual number of samples.
    def set_timebase_nsamples(self,
                              sampling_frequency=500e6,
                              number_of_captures=1000):
                              
        self.timebase,self.sampling_frequency = self.frequency_to_timebase(sampling_frequency)
        # compute expected number of samples
        expected_samples = int(self.samples_to_capture//2)
        
        computed_max_samples = ctypes.c_int32()
        status = ps5000a.ps5000aGetTimebase2(self.scope_handle, 
                                             self.timebase, 
                                             expected_samples,
                                             # ps5000aGetTimebase2 computes also
                                             # the sampling period, we do not need it
                                             ctypes.byref(ctypes.c_int32(0)), 
                                             ctypes.byref(computed_max_samples), 
                                             0)
        assert_pico_ok(status)

        return computed_max_samples.value
    
    def prepare_memory(self, number_of_captures=1):
        
        samples_per_capture = ctypes.c_int32()
        # ps5000aMemorySegments splits the scope buffer and computes the actual
        # max number of samples once the room for metadata is subtracted
        # note:samples_per_capture is the number of samples of *all* channels
        status = ps5000a.ps5000aMemorySegments(self.scope_handle, 
                                               number_of_captures,
                                               ctypes.byref(samples_per_capture))
        
        assert_pico_ok(status)
            
        self.buffer_list.append( (ctypes.c_int16 * samples_per_capture.value)() )
        #self.buffer_list.append( (ctypes.c_int16 * samples_per_capture.value)() )
        #self.buffer_list.append( (ctypes.c_int16 * samples_per_capture.value)() )
        #self.buffer_list.append( (ctypes.c_int16 * samples_per_capture.value)() )

        status = ps5000a.ps5000aSetDataBuffer(self.scope_handle, 
                                                ps5000a_channels[self.sampling_channel], 
                                                ctypes.byref(self.buffer_list[0]),
                                                #ctypes.byref(self.buffer_list[1]),
                                                samples_per_capture, 
                                                0, 
                                                0)
        assert_pico_ok(status)

        #status = ps5000a.ps5000aSetDataBuffers(self.scope_handle, 
        #                                        ps5000a_channels[self.trigger_channel], 
        #                                        ctypes.byref(self.buffer_list[2]),
        #                                        ctypes.byref(self.buffer_list[3]),
        #                                        samples_per_capture, 
        #                                        0, 
        #                                        0)
        #assert_pico_ok(status)
        return samples_per_capture.value
    
    def capture(self,
                samples_per_capture,
                pre_trigger_sample_ratio=0.05):
        # Starts the block capture
        # time indisposed ms = None (This is not needed within the example)
        # Segment index = 0
        # LpRead = None
        # pParameter = None
        single_channel_samples_per_capture = samples_per_capture // 2
        pre_trigger_samples = int(single_channel_samples_per_capture*pre_trigger_sample_ratio)
        post_trigger_samples = single_channel_samples_per_capture-pre_trigger_samples

        status = ps5000a.ps5000aRunBlock(self.scope_handle,
                                         # pre-trigger samples
                                         pre_trigger_samples, 
                                         # post-trigger samples
                                         post_trigger_samples, 
                                         self.timebase, 
                                         None, 
                                         0, 
                                         None, 
                                         None)
        assert_pico_ok(status)
        print(" - Sampling started")      
        return
    
    def get_traces(self,traces):
        ready = ctypes.c_int16(0)
        check = ctypes.c_int16(0)
        while ready.value == check.value:
            status = ps5000a.ps5000aIsReady(self.scope_handle, 
                                       ctypes.byref(ready))
        print(" - Scope ready to transfer back samples")         
        number_of_captures,samples_per_capture = traces.shape

        status = ps5000a.ps5000aGetValues(self.scope_handle, 
                                        0, # starting sample position
                                        ctypes.byref(ctypes.c_int32(samples_per_capture)), 
                                        0, #downsample ratio
                                        0,
                                        0, 
                                        ctypes.byref(ctypes.c_int16()))
        assert_pico_ok(status)

        self.get_np_array(traces[0])
        return

    def get_np_array(self, array):
        samples_per_capture = len(array)
        chunk_size = 1000000  
        for i in range(0, samples_per_capture-chunk_size, chunk_size):
            chunk = self.buffer_list[0][i:i+chunk_size]  
            array[i:i+chunk_size] = np.array(chunk) 

        chunk = self.buffer_list[0][i+chunk_size:samples_per_capture]
        array[i+chunk_size:samples_per_capture] = np.array(chunk)
        return
        
