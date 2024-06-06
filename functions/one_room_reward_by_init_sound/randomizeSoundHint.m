function vr = randomizeSoundHint(vr)
    randomNumber = vr.big_or_small_vec(vr.countTrials);
    if (randomNumber == 1)
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

