function vr = DAQInit(vr)
    global dataFromDAQ;
    global dataFromDAQ_FirstPrev;
    global dataFromDAQ_SecondPrev;
    global dataFromDAQ_Thirdprev;
    % reset DAQ in case it's still in use by a previous MATLAB program
    daqreset;
    % connect to the DAQ card dev1; store the input object handle in vr for use by ViRMEn
    vr.ai = daq.createSession('ni');
    vr.ai.IsContinuous = true;
    
    vr.ao = daq.createSession('ni');
    vr.ao.IsContinuous = true;
    
    addAnalogInputChannel(vr.ai,'Dev1',[8,9,13],'Voltage'); % A,B,lickport
    addAnalogOutputChannel(vr.ao,'Dev1',1,'Voltage'); %valve
    addDigitalChannel(vr.ao,'Dev1','Port0/Line5','OutputOnly'); % random signal
    addDigitalChannel(vr.ao,'Dev1','Port0/Line7','OutputOnly'); % valve


    % define the sampling rate to 1kHz and set the duration to be unlimited
    vr.ai.Rate = vr.rate;
    vr.ao.Rate = vr.rate;
    

    % set the buffering window to be 8 ms long - shorter than a single ViRMEn refresh cycle
    vr.ai.NotifyWhenDataAvailableExceeds = vr.rate / (100/vr.factorOfSampleWindow);
    vr.ao.NotifyWhenScansQueuedBelow  = vr.rate/10;
    

    vr.timeOfSample = vr.ai.Rate./vr.ai.NotifyWhenDataAvailableExceeds;
    vr.timePerSample = vr.ai.NotifyWhenDataAvailableExceeds./vr.ai.Rate;
    vr.lh1 = addlistener(vr.ai,'DataAvailable',@getData);
    
    function getData(src,event)
        dataFromDAQ_Thirdprev = dataFromDAQ_SecondPrev;
        dataFromDAQ_SecondPrev = dataFromDAQ_FirstPrev;
        dataFromDAQ_FirstPrev = dataFromDAQ;
        dataFromDAQ = [event.Data event.TimeStamps];
    end

    % start acquisition from the analog input object
    startBackground(vr.ai);

end
