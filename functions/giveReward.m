function vr = giveReward(vr)
    global dataFromDAQ;
    timestampCol = dataFromDAQ(:,4);
    rewardLength = round(vr.rate*vr.currentRewardDuration/1000); % how many ones to log
    data = ones(rewardLength,1)*4; % open valve for sec/10
    zero_data = zeros(vr.rate/10,1);
    vr.ao.queueOutputData(data);
    vr.ao.queueOutputData(zero_data);
%     outputData = logical([0 0 1 0 0 0 0 0]);  % Example output data
%     vr.ao.outputSingleScan(outputData);

    startBackground(vr.ao);

    fwrite(vr.fid3, [timestampCol(1) 1],'double');
    fwrite(vr.fid3, [timestampCol(1)+vr.currentRewardDuration/1000 1],'double');

%     start(vr.t3);
end