function vr = randomizeWorld(vr)
   randomNumber = rand;
    if (randomNumber < vr.stripesWorldPercentage)
        vr.currentWorld = vr.stripesWorld;
    else
        vr.currentWorld = vr.chessWorld;
    end
    % the precentage of correct running will be depended on the reward type
    if (vr.currentWorld == vr.chosenWorldToBeBigReward)
        vr.percentageThresholdOfCurrTrial = vr.percentageThresholdBig;
        vr.currentRewardDuration = vr.rewardDurationBig;
    else
        vr.percentageThresholdOfCurrTrial = vr.percentageThresholdSmall;
        vr.currentRewardDuration = vr.rewardDurationSmall;
    end
end

