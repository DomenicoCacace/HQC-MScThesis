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
        self.scope_handle = ctypes.c_int16(0)
        # size of the scope buffer, in bytes according to specs, used in single-
        # capture mode as there is no way of getting it via API
        self.spec_buffer_size = 511*1024*1024
        # size of the scope buffer, according to the ps5000aGetTimebase2 call 
        self.scope_max_samples = 0
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
    # trigger threshold in mV and "advanced" api for picoscope library calls
    # Simple api had bugs in previous releases, leading the scope to capture
    # in auto-mode
    def config_trigger(self,
                       threshold = 750,
                       direction = "Rising", 
                       api_used="advanced"):
        
        maxADC = ctypes.c_int16()
        ps5000a.ps5000aMaximumValue(self.scope_handle, ctypes.byref(maxADC))
        #convert threshold to ADC value
        adcthreshold = int(mV2adc(threshold,ps5000a_ranges[self.trigger_range], maxADC))
        enable_channel = 1
        delay = 0
        autotrigger_after_ms = 10000
        if (api_used == "simple"):
            status = ps5000a.ps5000aSetSimpleTrigger(self.scope_handle,
                                                     enable_channel, 
                                                     ps5000a_channels[self.trigger_channel], 
                                                     adcthreshold, 
                                                     ps5000a_trigger_dir[direction], 
                                                     delay, 
                                                     autotrigger_after_ms)
            assert_pico_ok(status)
        else:                                   
            threshold_hysteresis = 10
            threshold_low = 0
            triggerProperties = ps5000a.PS5000A_TRIGGER_CHANNEL_PROPERTIES_V2(adcthreshold,
                                                                         threshold_hysteresis,
                                                                         threshold_low,
                                                                         threshold_hysteresis,
                                                                         1)
            length_of_trigger_properties_array = 1
            unused = 0
            status = ps5000a.ps5000aSetTriggerChannelPropertiesV2(self.scope_handle, 
                                                             ctypes.byref(triggerProperties), 
                                                             length_of_trigger_properties_array, 
                                                             unused)
            
            triggerConditions = ps5000a.PS5000A_CONDITION(ps5000a_channels[self.trigger_channel],1)
            
            clear_flag = 1
            add_flag = 2
            length_of_conditions_array = 1
            status = ps5000a.ps5000aSetTriggerChannelConditionsV2(self.scope_handle, 
                                                             ctypes.byref(triggerConditions), 
                                                             length_of_conditions_array, 
                                                             (clear_flag | add_flag))
            
            triggerDirections = ps5000a.PS5000A_DIRECTION(ps5000a_channels[self.trigger_channel], 
                                                     2,#ps5000a_trigger_dir[direction], 
                                                     0)#ps5000a.PS5000A_THRESHOLD_MODE["PS5000A_LEVEL"])
            length_of_directions_array = 1
            status = ps5000a.ps5000aSetTriggerChannelDirectionsV2(self.scope_handle, 
                                                             ctypes.byref(triggerDirections), 
                                                             length_of_directions_array)
                                               
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
        #if (self.trigger_channel == "Channel_B"):
            #samples_per_trace = (self.spec_buffer_size/2)/number_of_captures
        #else:
            #print("handle external trigger in buffering")
            #samples_per_trace = (self.spec_buffer_size)/number_of_captures
            
        self.timebase,self.sampling_frequency = self.frequency_to_timebase(sampling_frequency)
        # compute expected number of samples
        expected_samples = self.spec_buffer_size//number_of_captures
        
        sampled_interval_in_nanosecs = ctypes.c_int32()
        computed_max_samples = ctypes.c_int32()
        status = ps5000a.ps5000aGetTimebase2(self.scope_handle, 
                                             self.timebase, 
                                             expected_samples,
                                             ctypes.byref(computed_max_samples), 
                                             # ps5000aGetTimebase2 computes also
                                             # the sampling period, we do not need it
                                             ctypes.byref(sampled_interval_in_nanosecs), 
                                             0)
        self.scope_max_samples = computed_max_samples.value
        return computed_max_samples.value
    
    def prepare_memory(self, number_of_captures=1000):
        samples_per_capture = ctypes.c_int32()
        my_PS5000A_RATIO_MODE_NONE = 0        

        if (number_of_captures > 1):
            # Target memory needs splitting.
            # ps5000aMemorySegments splits the scope buffer and computes the actual
            # max number of samples once the room for metadata is subtracted
            # note: samples_per_capture is the number of samples of *all* channels
            status = ps5000a.ps5000aMemorySegments(self.scope_handle, 
                                                   number_of_captures,
                                                   ctypes.byref(samples_per_capture))
            
            assert_pico_ok(status)
            max_segments = ctypes.c_int32()
            ps5000a.ps5000aGetMaxSegments(self.scope_handle, 
                                          ctypes.byref(max_segments))
            print(f"Splitting buffer into {number_of_captures} two-channel traces of {samples_per_capture} samples each")
            # sets number of captures
            status = ps5000a.ps5000aSetNoOfCaptures(self.scope_handle, 
                                                    number_of_captures)
            assert_pico_ok(status)
            
            # this buffer will contain the entirety of the scope buffer the 
            # split is determined by the sequence of ps5000aSetDataBuffer calls
            print(f"Allocating {number_of_captures} buffers, each one {samples_per_capture.value} long")
            for segment_idx in range(number_of_captures):        
                self.buffer_list.append( (ctypes.c_int16 * samples_per_capture.value)() )
            for segment_idx in range(number_of_captures):
                # the last parameter is the downsampling mode 
                status = ps5000a.ps5000aSetDataBuffer(self.scope_handle, 
                                                 ps5000a_channels[self.sampling_channel], 
                                                 ctypes.byref(self.buffer_list[segment_idx]), 
                                                 samples_per_capture, 
                                                 segment_idx, 
                                                 my_PS5000A_RATIO_MODE_NONE)                
            assert_pico_ok(status)

        else:
            # single capture with entire buffer, the target memory does not need
            # splitting the number of samples per acquisition is the one 
            # from the ps5000aGetTimebase2 call done by set_timebase_nsamples
            samples_per_capture.value = self.spec_buffer_size
            # the list of buffers containing data for the capture has a single 
            # element 
            self.buffer_list.append( (ctypes.c_int16 * samples_per_capture.value)() )
            self.unused_buffer_due_to_picoscope_API = (ctypes.c_int16 * samples_per_capture.value)()
            segment_idx = 0     
            status = ps5000a.ps5000aSetDataBuffers(self.scope_handle, 
                                              ps5000a_channels[self.sampling_channel], 
                                              ctypes.byref(self.buffer_list[segment_idx]), 
                                              ctypes.byref(self.unused_buffer_due_to_picoscope_API), 
                                              samples_per_capture, 
                                              segment_idx, 
                                              my_PS5000A_RATIO_MODE_NONE)
            assert_pico_ok(status)
            pass

            
        return samples_per_capture.value
    
    def capture(self,
                samples_per_capture,
                proportional_pretrigger_amount=True,
                pre_trigger_sample_ratio = 0.05,
                pre_trigger_absolute_samples = 1000):
        # Starts the block capture
        # time indisposed ms = None (This is not needed within the example)
        # Segment index = 0
        # LpRead = None
        # pParameter = None
        single_channel_samples_per_capture = samples_per_capture // 2
        if (proportional_pretrigger_amount):
            pre_trigger_samples = int(single_channel_samples_per_capture*pre_trigger_sample_ratio)
        else:
            if( pre_trigger_absolute_samples > single_channel_samples_per_capture):
                printf("Warning pre_trigger_absolute_samples are longer than the number of samples")
                printf("Setting pre_trigger_absolute_samples = number of samples - 1")
                pre_trigger_samples = pre_trigger_absolute_samples-1
            else:
                pre_trigger_samples = pre_trigger_absolute_samples
            
        post_trigger_samples = single_channel_samples_per_capture - pre_trigger_samples
            
        memory_segment_index = 0
        status = ps5000a.ps5000aRunBlock(self.scope_handle,
                                         # pre-trigger samples
                                         pre_trigger_samples, 
                                         # post-trigger samples
                                         post_trigger_samples, 
                                         self.timebase, 
                                         None, 
                                         memory_segment_index, 
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
        expected_samples = ctypes.c_int32(samples_per_capture)
        fetched_samples = ctypes.c_int32(samples_per_capture)
        my_PS5000A_RATIO_MODE_NONE = 0
        downsample_ratio = 0
        overflow_flags_buffer = (ctypes.c_int16 * number_of_captures)()
        if (number_of_captures > 1):
            status= ps5000a.ps5000aGetValuesBulk(self.scope_handle, 
                                             ctypes.byref(fetched_samples), 
                                             0, # starting segment index 
                                             number_of_captures-1, # final segment index 
                                             downsample_ratio, 
                                             my_PS5000A_RATIO_MODE_NONE, 
                                             ctypes.byref(overflow_flags_buffer))
        else:
            status = ps5000a.ps5000aGetValues(self.scope_handle, 
                                         0, # starting segment index
                                         ctypes.byref(fetched_samples), 
                                         downsample_ratio, 
                                         my_PS5000A_RATIO_MODE_NONE, 
                                         0, # host side memory segment index
                                            # yes, it's useless, but the call
                                            # needs it
                                         ctypes.byref(overflow_flags_buffer))
        assert_pico_ok(status)      
       
        if (expected_samples.value != fetched_samples.value):
            print(f"Fetched {fetched_samples},expected {expected_samples}")        
        else:
            print("Samples transferred, lifting to desired numpy type")
            for i in range(number_of_captures):
                traces[i] = np.ctypeslib.as_array(self.buffer_list[i][:samples_per_capture])
                print("lifting done")
        return
        