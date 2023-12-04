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
    vr.TrialTimelineFile = 'TrialTimeline.dat';
    vr.SoundGivenFile = 'SoundGiven.dat';

    vr.configDataFile = 'config.json';
    vr.FolderName ="";
    %total time ran in range in a single trial (excluding reward room and
    %black room)
    vr.timeOfRanningInRange = 0;
    %total time in trial(excluding reward room and black room)
    vr.timeOfTotalRun = 0;
    %counting amount of finished trials in a session.
    vr.countTrials = 1;
    %the start of the reward room
    vr.endOftheRoad = 200;

    %flag so it will not give reward more than once
    vr.isRewardGiven = 0;
    %threshold for reward
    vr.percentageThresholdOfCurrTrial = 0;
    %duration to open the valve for based on big\small reward
    vr.currentRewardDuration = 0;
    %default menu config file
    vr.configToLoadOnGui = 'C:\Users\user\Desktop\imaging_system\ViRMEn 2016-02-12\config\config.json';
    %saving the last 30 ms for velocity
    vr.fourthPrevious10msVelocity = 0;    
    vr.thirdPrevious10msVelocity = 0;
    vr.secondPrevious10msVelocity = 0;
    vr.previous10msVelocity = 0;
    vr.current10msVelocity = 0;
    
    vr.velocityScaling = 3; % for mooving the starting point back and still finish on the same time as normal
    vr.factorOfSampleWindow = 1; %how much do we want to extend our sampling window
    vr.numberOfBufffersCombined = 4; %how many buffers did we use to calculate the spead
    vr.rate = 20000; % num of samples per sec
    global dataFromDAQ;
    global dataFromDAQ_FirstPrev;
    global dataFromDAQ_SecondPrev;
    global dataFromDAQ_Thirdprev;

    dataFromDAQ = zeros( vr.rate / (100/vr.factorOfSampleWindow),4);
    dataFromDAQ_FirstPrev = zeros( vr.rate / (100/vr.factorOfSampleWindow),4);
    dataFromDAQ_SecondPrev = zeros( vr.rate / (100/vr.factorOfSampleWindow),4);
    dataFromDAQ_Thirdprev = zeros( vr.rate / (100/vr.factorOfSampleWindow),4);
    


%     vr.oneRoundOfWheel = 59; % in virmen's units
%     vr.wheelRadius = 9.525; % cm
%     vr.wheelPerimeter = 2*pi*vr.wheelRadius;
    vr.meterTovirmenUnits = 1;
    vr.avgVelocity = (vr.current10msVelocity + vr.previous10msVelocity + vr.secondPrevious10msVelocity + vr.thirdPrevious10msVelocity + vr.fourthPrevious10msVelocity)/5;
    
    %vr.configToLoadOnGui = 'C:\Users\user\Desktop\imaging_system\ViRMEn 2016-02-12\config\config.json';
end

