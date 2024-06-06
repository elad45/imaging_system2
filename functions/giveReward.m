function vr = giveReward(vr)
    global dataFromDAQ;
    try
        timestampCol = dataFromDAQ(:,5);
    catch ME
        disp(['Error: ' ME.message]);
        timestampCol = dataFromDAQ(:,4);

    end   
    
    rewardLength = round(vr.rate*vr.currentRewardDuration/1000); % how many ones to log
    reward_data = ones(rewardLength,1); % open valve for sec/10 
    zero_data_analog = zeros(rewardLength,1);
    zero_data_digital = zeros(vr.rate/10,1);
    % send the reward to the relevant ports and 0 in the rest
    reward_to_send = [reward_data*4 zero_data_analog reward_data];  % analog_valve sync_singla digial_valve
    % close the valve by sending 0 to all ports
    zero_to_send = [zero_data_digital zero_data_digital zero_data_digital];
    combined = [reward_to_send ; zero_to_send];
    % send a signal to the light port
    if (7>5)
        light_buffer = 10;
        light_signal = 100;
        % create buffer between the start of the light and the rest of the
        % output signals
        lightLength = round(vr.rate*light_signal/1000); % how many ones to queue
        light_buffer_Length = round(vr.rate*light_buffer/1000); % how many ones to queue

        light_data = ones(lightLength,1);
        light_buffer_padding = zeros(light_buffer_Length,1);
        light_buffer_data = ones(light_buffer_Length,1);
        pre_light_to_send = [light_buffer_padding light_buffer_padding light_buffer_padding];
        % send activation signals from the start of the buffer into the
        % signal itself and endwith 0's like the rest
        a = [light_buffer_data; light_data; zero_data_digital];
        combined1 = [pre_light_to_send ;combined];
        % send all the output signals together
        combined2 = [combined1 a];
          
    else
        a = [zero_data_analog ; zero_data_digital];
        % send all the output signals together
        combined2 = [combined a];
    end
    vr.ao.queueOutputData(combined2); % valve analog, random signal, valve digital

    startBackground(vr.ao);
    fwrite(vr.fid3, [timestampCol(1) timestampCol(1)+vr.currentRewardDuration/1000 vr.countTrials vr.currentRewardDuration],'double');
%     fwrite(vr.fid3, [timestampCol(1)+vr.currentRewardDuration/1000 1],'double');
end