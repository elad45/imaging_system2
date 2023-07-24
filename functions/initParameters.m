function vr = initParameters(vr)
    vr.isSessionRun = false; %check if settings on gui has been set or X was pressed.
    vr.blackRoom = 2;
    vr.stripesWorld = 1;
    vr.chessWorld = 3;
    vr.stripesWorldPercentage = 0.5; 
    vr.counter = 0;
    vr.velocityDataFile = 'velocity.dat';
    vr.ABDataFile = 'A-B_leakport_record.dat';
    vr.RewardDataFile = 'Reward.dat';
    vr.syncLog = 'sync_signal.dat';
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

    vr.wheelRadius = 9.525; % cm
    vr.wheelPerimeter = 2*pi*vr.wheelRadius;
    vr.oneRoundOfWheel = 118; % in virmen's units
    vr.meterTovirmenUnits = vr.oneRoundOfWheel /vr.wheelPerimeter;
    %flag so it will not give reward more than once
    vr.isRewardGiven = 0;
    %threshold for reward
    vr.percentageThresholdOfCurrTrial = 0;
    %duration to open the valve for based on big\small reward
    vr.currentRewardDuration = 0;
    %default menu config file
    vr.configToLoadOnGui = strcat(pwd,'\ViRMEn 2016-02-12\config\config.json');
    %saving the last 30 ms for velocity
    vr.beforePrevious10msVelocity = 0;
    vr.previous10msVelocity = 0;
    vr.current10msVelocity = 0;
    vr.avgVelocity = (vr.beforePrevious10msVelocity + vr.previous10msVelocity + vr.current10msVelocity)/3;
    %vr.configToLoadOnGui = 'C:\Users\user\Desktop\imaging_system\ViRMEn 2016-02-12\config\config.json';
end

