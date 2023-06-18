function vr = isExistsDefaultConfig(vr)
    if exist(vr.configToLoadOnGui, 'file') == 2
        fprintf("The file '%s' exists.\n", vr.configToLoadOnGui);
        % Perform your desired actions when the file exists
    else
        fprintf("The file '%s' does not exist.\n", vr.configToLoadOnGui);
        % Perform your desired actions when the file doesn't exist
        vr.amountTrials = str2double("4");
        vr.percentageThresholdSmall = str2double("70");
        vr.percentageThresholdBig = str2double("70");
        vr.rewardDurationSmall = str2double("90");
        vr.rewardDurationBig = str2double("150");
        vr.soundProfile = str2double("1");
        vr.chosenWorldToBeBigReward = str2double("1");
        vr.distanceToRun = str2double("200");
        vr.leakportBreak = str2double("2");
        vr.blackRoomBreak = str2double("2");
        vr.allowedDeviation = str2double("16");
        vr.targetSpeed = str2double("31");
        vr.DeviationBetweenSteps = str2double("16");
        %save the file
        saveConfigFile(vr,vr.configToLoadOnGui);
    end
end

