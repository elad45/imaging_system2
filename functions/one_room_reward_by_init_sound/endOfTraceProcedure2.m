function vr = endOfTraceProcedure2(vr)
    global timeUntilCoolOffRoom;
    global dataFromDAQ;
    %1 for switching to black room and 2 for jumping back to start
    timestampCol = dataFromDAQ(:,4);
    vr = stopSound(vr);
    
    % Start the timer object   
    if (isequal(get(vr.t1, 'Running'), 'off'))
        start(vr.t1);

        if((double(vr.timeOfRanningInRange)/double(vr.timeOfTotalRun) >= vr.percentageThresholdOfCurrTrial/100)&&(vr.isRewardGiven == false ))
            vr = giveReward(vr); % activate reward
            vr.isRewardGiven = true;
        end
    end
    
    %check if the time to switch rooms has arrived
    if (timeUntilCoolOffRoom ~= 0)
        %check which room
        if (timeUntilCoolOffRoom == 1)
            vr.currentWorld = vr.blackRoom;
            if (isequal(get(vr.t2, 'Running'), 'off'))
                start(vr.t2);
            end

        else
            %go back to init position
            vr.countTrials = vr.countTrials + 1;
            if (vr.countTrials > vr.amountTrials)
                vr.experimentEnded = true;
            else
                vr.currentWorld = vr.chessWorld;
                vr = randomizeSoundHint(vr);
                
                vr.position(2) = vr.initPosition;
                scans_length = vr.ao.NotifyWhenScansQueuedBelow;
                vr = clockAlignment(vr,scans_length); % aligment for the other sensors
                fwrite(vr.fid5, [timestampCol(1) vr.countTrials vr.currentRewardDuration],'double'); %write to file that we started another trial
                
                vr.isRewardGiven = false;
                %reset timers
                stop(vr.t1);
                stop(vr.t2);
                
                disp(['current trial number:' num2str(vr.countTrials) '\' num2str(vr.amountTrials)]); % show the current trial number

            end
        end
        timeUntilCoolOffRoom = 0;
    end
end

