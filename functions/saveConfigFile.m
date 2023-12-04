function vr = saveConfigFile(vr,file_path)
data = struct('db_amount_trials', vr.amountTrials,...
              'db_threshold_open_valve_small', vr.percentageThresholdSmall,...
              'db_threshold_open_valve_big', vr.percentageThresholdBig,...
              'db_reward_duration_small', vr.rewardDurationSmall,...
              'db_reward_duration_big',vr.rewardDurationBig,...
              'db_sound_option',vr.soundProfile,...
              'db_world_option',vr.chosenWorldToBeBigReward,...
              'db_distance_to_run',round(vr.distanceToRun/vr.meterTovirmenUnits),...
              'db_leakport_room_break',vr.leakportBreak,...
              'db_black_room_break', vr.blackRoomBreak,...
              'db_sound_deviation_in_range',vr.allowedDeviation,...
              'db_target_speed',vr.targetSpeed,...
              'db_sound_deviation_out_range',vr.DeviationBetweenSteps,...
              'db_Folder_name', vr.FolderName);%put it last
                
json_str = '{';

fields = fieldnames(data);
numFields = numel(fields);
for i = 1:numFields
    if i ~= numFields
    json_str = [json_str, sprintf('\n  "%s": "%d",\n', fields{i}, data.(fields{i}))];
    else
    json_str = [json_str, sprintf('\n  "%s": "%s"\n', fields{i}, data.(fields{i}))];
    end
end

 
json_str = [json_str, '}'];

try
    fileID = fopen(file_path, 'w');
    
    if fileID == -1
        error('Unable to open the file for writing.');
    end
    
    fwrite(fileID, json_str, 'char');
    fclose(fileID);
catch exception
    fprintf('Error: %s\n', exception.message);
end

end

