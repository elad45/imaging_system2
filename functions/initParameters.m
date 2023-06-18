function vr = initParameters(vr)
    vr.isSessionRun = false; %check if settings on gui has been set or X was pressed.
    vr.blackRoom = 2;
    vr.stripesWorld = 1;
    vr.chessWorld = 3;
    vr.stripesWorldPercentage = 0.5; 
    vr.counter = 0;
    vr.velocityDataFile = 'velocity.dat';
    vr.ABDataFile = 'A-B_record.dat';
    vr.RewardDataFile = 'Reward.dat';
    vr.configDataFile = 'config.json';
    %total time ran in range in a single trial (excluding reward room and
    %black room)
    vr.timeOfRanningInRange = 0;
    %total time in trial(excluding reward room and black room)
    vr.timeOfTotalRun = 0;
    %counting amount of finished trials in a session.
    vr.countTrials = 0;
    %the start of the reward room
    vr.endOftheRoad = 220;

    %flag so it will not give reward more than once
    vr.isRewardGiven = 0;
    %threshold for reward
    vr.percentageThresholdOfCurrTrial = 0;
    %duration to open the valve for based on big\small reward
    vr.currentRewardDuration = 0;
    %default menu config file
    vr.configToLoadOnGui = 'C:\Users\user\Desktop\imaging_system\ViRMEn 2016-02-12\config\config.json';
end

