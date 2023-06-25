function vr = giveReward(vr)
    global dataFromDAQ;
    timestampCol = dataFromDAQ(:,4);
    rewardLength = round(vr.rate*vr.currentRewardDuration/1000); % how many ones to log
    data = ones(rewardLength,1)*4; % open valve for sec/10
    zero_data_analog = zeros(rewardLength,1);
    zero_data_digital = zeros(vr.rate/10,1);
    vr.ao.queueOutputData([data zero_data_analog]);
    vr.ao.queueOutputData([zero_data_digital zero_data_digital]);

    startBackground(vr.ao);

    fwrite(vr.fid3, [timestampCol(1) 1],'double');
    fwrite(vr.fid3, [timestampCol(1)+vr.currentRewardDuration/1000 1],'double');
end