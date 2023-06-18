function vr = createLogFiles(vr)
    % open or create binary file for writing and store its file ID in vr
    timestampForFileName = datestr(clock);    
    vr.sessionFolder = fullfile('C:\Users\user\Desktop\imaging_system\ViRMEn 2016-02-12\log', erase(timestampForFileName,":"));
    mkdir(vr.sessionFolder);
    %vr.nameOfLogFileVel = "C:\Users\user\Desktop\imaging_system\log\" + erase(timestampForFileName+"velocity.dat",":");
    vr.nameOfLogFileVel = fullfile(vr.sessionFolder,vr.velocityDataFile);
    vr.fid1 = fopen(vr.nameOfLogFileVel,'w');
    %vr.nameOfLogFileA_B = "C:\Users\user\Desktop\imaging_system\log\" + erase(timestampForFileName+"A-B_record.dat",":");
    vr.nameOfLogFileA_B = fullfile(vr.sessionFolder,vr.ABDataFile);
    vr.fid2 = fopen(vr.nameOfLogFileA_B,'w');
    %vr.nameOfLogFileReward = "C:\Users\user\Desktop\imaging_system\log\" + erase(timestampForFileName+"Reward.dat",":");
    vr.nameOfLogFileReward = fullfile(vr.sessionFolder,vr.RewardDataFile);
    vr.fid3 = fopen(vr.nameOfLogFileReward,'w');
    
    %vr.nameOfLogFileConfigTest = "C:\Users\user\Desktop\imaging_system\log\" + erase(timestampForFileName+"config.json",":");
    %it saves the config here
    vr.configFileInSession = fullfile(vr.sessionFolder,vr.configDataFile);

    
end
