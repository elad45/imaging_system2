function vr = plotData(vr)
    % open the binary file
%     fid1 = fopen(vr.nameOfLogFileA_B);
    fid2 = fopen(vr.nameOfLogFileVel);
    fid3 = fopen(vr.nameOfLogFileReward);
    fid5 = fopen(vr.nameOfLogFileTrials);
    % read all data from the file into a 5-row matrix
    velocityData = fread(fid2,[5 inf],'double');
%     A_B_ChannelsData = fread(fid1,[4 inf],'double');
    rewardData = fread(fid3,[4 inf],'double');
    trialData = fread(fid5,[3 inf], 'double');
%     trialData = [zeros(size(trialData, 1), 1) trialData];
    % close the file
%     fclose(fid1);
    fclose(fid2);
    fclose(fid3);
    fclose(fid5);

    % plot the 2D position information
    figure;
    hold on;
    plot(velocityData(1,:),velocityData(2,:),'b-');
    plot(velocityData(1,:),velocityData(3,:),'r-');
    plot(velocityData(1,:),velocityData(4,:),'g-');
    hold off;
    xlabel('Time (s)');
    ylabel('Speed (cm\\s)');
    legend('Velocity', 'Average Velocity', 'Lickport activation');
    title("velocityData");

end

    