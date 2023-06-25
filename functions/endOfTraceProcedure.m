function vr = endOfTraceProcedure(vr)
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
            vr = clockAlignment(vr); % aligment of the other sensors 
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
            if (vr.countTrials >= vr.amountTrials)
                vr.experimentEnded = true;
            else
%                 randomNumber = rand;
%                 if (randomNumber < vr.stripesWorldPercentage)
%                     vr.currentWorld = vr.stripesWorld;
%                 else
%                     vr.currentWorld = vr.chessWorld;
%                 end
%                 
%                 % the precentage of correct running will be depended on the reward type
%                 if (vr.currentWorld == vr.chosenWorldToBeBigReward)
%                     vr.percentageThresholdOfCurrTrial = vr.percentageThresholdBig;
%                 else
%                     vr.percentageThresholdOfCurrTrial = vr.percentageThresholdSmall;
%                 end
                vr = randomizeWorld(vr);
                %vr.currentWorld = vr.chosenWorld;
                vr.position(2) = vr.initPosition;
                vr.isRewardGiven = false;
                %reset timers
                stop(vr.t1);
                stop(vr.t2);
            end
        end
        timeUntilCoolOffRoom = 0;
    end
end

