function code = myExp
% defaultVirmenCode   Code for the ViRMEn experiment defaultVirmenCode.
%   code = defaultVirmenCode   Returns handles to the functions that ViRMEn
%   executes during engine initialization, runtime and termination.


% Begin header code - DO NOT EDIT
code.initialization = @initializationCodeFun;
code.runtime = @runtimeCodeFun;
code.termination = @terminationCodeFun;
% End header code - DO NOT EDIT

end


% --- INITIALIZATION code: executes before the ViRMEn engine starts.
function vr = initializationCodeFun(vr)
    global timeUntilCoolOffRoom;
    timeUntilCoolOffRoom = 0;
    %start the sound server
    command = 'start /B cmd /C node "C:\Users\user\Desktop\imaging_system\ViRMEn 2016-02-12\sound_server\serverWeb.js"';
    system(command);

    
    vr = initParameters(vr);
    vr = isExistsDefaultConfig(vr);
    vr = miniGUI(vr); % show the GUI for chosing the experiment preferences
    vr = DAQInit(vr); % data acquisition system

    if vr.isSessionRun == true    
        vr = createLogFiles(vr); % for logging all files
       
        %save config in the session directory
        vr = saveConfigFile(vr,vr.configFileInSession); 
        %save config in default config as well
        copyfile(vr.configFileInSession,vr.configToLoadOnGui);
        %calculating & set initial position
        vr.initPosition = vr.endOftheRoad - vr.distanceToRun*vr.velocityScaling;
        vr.position(2) = vr.initPosition;
        
        vr = timerInit(vr); % start the timers for changing rooms
        vr = randomizeWorld(vr);
        vr = clockAlignment(vr,vr.ao.NotifyWhenScansQueuedBelow); % aligment of the other sensors
        fwrite(vr.fid5, [0 vr.countTrials vr.currentRewardDuration],'double'); %write to file that we started the first trial

        disp(['current trial number:' num2str(vr.countTrials) '\' num2str(vr.amountTrials)]); % show the current trial number
        
    end
end




% --- RUNTIME code: executes on every iteration of the ViRMEn engine.
function vr = runtimeCodeFun(vr)
    %choose the sound policy
    switch vr.soundProfile
        case 1
            desiredFreq = 3000; %this will represent the file name that will be activated ("sound3000.wav")
            vr = soundInRangeA(vr, vr.targetSpeed, vr.allowedDeviation, desiredFreq);
        case 2
            desiredFreq = 3000;
            vr = soundEqualB(vr, vr.targetSpeed, vr.allowedDeviation, vr.DeviationBetweenSteps, desiredFreq);
        case 3
            desiredFreq = 3000;
            vr = soundDiffC(vr, vr.targetSpeed, vr.allowedDeviation,vr.DeviationBetweenSteps,desiredFreq);
        otherwise
            disp('ERROR selecting sound profile')
    end
    

    %checking position for reward
    if (vr.position(2)>=vr.endOftheRoad)
        vr = endOfTraceProcedure(vr);
    else
        % count the total time on trace before reaching to the end
        vr.timeOfTotalRun = vr.timeOfTotalRun + vr.ai.NotifyWhenDataAvailableExceeds;
        %count how much time it has been on the good range
        if((vr.targetSpeed  <= vr.velocity(2) + vr.allowedDeviation) && ...
            (vr.targetSpeed  >= vr.velocity(2) - vr.allowedDeviation))
            vr.timeOfRanningInRange = vr.timeOfRanningInRange+vr.ai.NotifyWhenDataAvailableExceeds;
        end
    end

    vr = calculateAvgSpeed(vr);
end

% --- TERMINATION code: executes after the ViRMEn engine stops.
function vr = terminationCodeFun(vr)
    if vr.isSessionRun == true
        vr = stopSound(vr);
        vr = freeAlocations(vr);
        datToCSV(vr.sessionFolder);
        vr = plotData(vr);
    end
end
