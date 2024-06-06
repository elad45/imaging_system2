function vr = generateSound(vr,freq)
    global dataFromDAQ;
    dataFromDAQ

    try
        timestampCol = dataFromDAQ(:,5);
    catch ME
        disp(['Error: ' ME.message]);
        timestampCol = dataFromDAQ(:,4);

    end
    url = strcat('http://127.0.0.1:3000/playSound',int2str(freq));
    try
%         time_of_light = 100; % ms
%         length = round(vr.rate*time_of_light/1000); % how many ones to log
%         zero_data_digital = zeros(length,1);
%         data = ones(length,1); % open valve for sec/10
% %         valve analog, random signal, valve digital,light
%         vr.ao.queueOutputData([zero_data_digital zero_data_digital zero_data_digital data]); 
%         vr.ao.queueOutputData([zero_data_digital zero_data_digital zero_data_digital zero_data_digital]);
%         toc
%         startBackground(vr.ao);
        options = weboptions('RequestMethod', 'get');
        webread(url, options);
        fwrite(vr.fid6, [timestampCol(1) freq vr.countTrials vr.currentRewardDuration], 'double');
   
%         disp('GET request sent successfully from generateSound.');

    catch ME
        disp(['Error: ' ME.message]);
    end

end
