function vr = randomizeSoundHint(vr)
   randomNumber = rand;
    if (randomNumber < vr.stripesWorldPercentage)
       desiredFreq = 14000;
    else
       desiredFreq = 8000;
    end
        
    if (desiredFreq == 14000)
        vr.percentageThresholdOfCurrTrial = 0;
        vr.currentRewardDuration = vr.rewardDurationBig;
    else
        vr.percentageThresholdOfCurrTrial = 0;
        vr.currentRewardDuration = vr.rewardDurationSmall;
    end
    
    vr = generateSound(vr,desiredFreq);

end

