function vr = randomizeSoundHint(vr)
   randomNumber = rand;
    if (randomNumber < vr.stripesWorldPercentage)
       desiredFreq = 3200;
    else
       desiredFreq = 1200;
    end
    
    vr = generateSound(vr,desiredFreq);
    
    % the precentage of correct running will be depended on the reward type
    if (desiredFreq == 3200)
        vr.percentageThresholdOfCurrTrial = 0;
        vr.currentRewardDuration = vr.rewardDurationBig;
    else
        vr.percentageThresholdOfCurrTrial = 0;
        vr.currentRewardDuration = vr.rewardDurationSmall;
    end
end

