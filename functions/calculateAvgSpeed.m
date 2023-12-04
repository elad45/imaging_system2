function vr = calculateAvgSpeed(vr)
    global dataFromDAQ;
    global dataFromDAQ_FirstPrev;
    global dataFromDAQ_SecondPrev;
    global dataFromDAQ_Thirdprev;
    
    numOfSlits = 0; % slits passed in the rotary encoder
    direction = runDirection(dataFromDAQ);
    AcolCurr = dataFromDAQ(:,1); % current buffer
    BcolCurr = dataFromDAQ(:,2); % current buffer
    Acol = [dataFromDAQ_Thirdprev(:,1);dataFromDAQ_SecondPrev(:,1);dataFromDAQ_FirstPrev(:,1);dataFromDAQ(:,1)]; % concat buffer with previous ones
    Bcol = [dataFromDAQ_Thirdprev(:,2);dataFromDAQ_SecondPrev(:,2);dataFromDAQ_FirstPrev(:,2);dataFromDAQ(:,2)];
    lickPortCol = dataFromDAQ(:,3);
    timestampCol = dataFromDAQ(:,4);
   
    length = numel(Bcol);
    for i = 2:length
        tmp = Bcol(i-1) + Bcol(i);
        if tmp>3 && tmp < 6 % Volt bounderies - expected to be 4 when activated
            numOfSlits = numOfSlits +1;
        end
    end
    numOfSlits = numOfSlits/2; % we increase the slits by one every start of 1's and every end
    % extract the speed from the encoder
    linearSpeedPerSlit = 5.8445/vr.factorOfSampleWindow; % 0.058 per 10 ms
    speed = (numOfSlits/vr.numberOfBufffersCombined)*linearSpeedPerSlit; % cm/s 
    %this round velocity
    vr.current10msVelocity = speed*direction;
    %calculating the average of the last 30ms for velocity, and using it as
    %this iteration velocity - this one is passed to moveWithDAQ
    
    vr.avgVelocity = (vr.current10msVelocity + vr.previous10msVelocity + vr.secondPrevious10msVelocity + vr.thirdPrevious10msVelocity + vr.fourthPrevious10msVelocity)/5;
    
    %replacing 5->4->3->2->1 for next iteration   
    vr.fourthPrevious10msVelocity = vr.thirdPrevious10msVelocity;
    vr.thirdPrevious10msVelocity = vr.secondPrevious10msVelocity;
    vr.secondPrevious10msVelocity = vr.previous10msVelocity;
    vr.previous10msVelocity = vr.current10msVelocity;

    
    vr = logData(vr, AcolCurr, BcolCurr, lickPortCol, vr.current10msVelocity, vr.avgVelocity, timestampCol);

end

