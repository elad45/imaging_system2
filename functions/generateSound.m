function vr = generateSound(vr,freq)
    global dataFromDAQ;
    timestampCol = dataFromDAQ(:,4);
    
    url = strcat('http://127.0.0.1:3000/playSound',int2str(freq));
    try
        options = weboptions('RequestMethod', 'get');
        webread(url, options);
        fwrite(vr.fid6, [timestampCol(1) freq vr.countTrials vr.currentRewardDuration], 'double');
%         disp('GET request sent successfully from generateSound.');

    catch ME
        disp(['Error: ' ME.message]);
    end

end
