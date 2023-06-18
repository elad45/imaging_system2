function velocity = moveWithDAQ(vr)
    global dataFromDAQ;
    %if(isempty(dataFromDAQ))
     %  velocity = [0 0 0 0];
     %   return
    %end
    numOfSlits = 0; % slits in the rotary encoder
    direction = runDirection(dataFromDAQ);
%     direction = 1;
    Acol = dataFromDAQ(:,1);
    Bcol = dataFromDAQ(:,2);
    lickPortCol = dataFromDAQ(:,3);

    timestampCol = dataFromDAQ(:,4);
    length = numel(Bcol);
    for i = 2:length
        tmp = Bcol(i-1) + Bcol(i);
        if tmp>3 && tmp < 6 % Volt bounderies - expected to be 4 when activated
            numOfSlits = numOfSlits +1;
        end
    end
    % extract the speed from the encoder
    linearSpeedPerSlit = 5.8445;
    speed = numOfSlits*linearSpeedPerSlit; % cm/s 
    scaling = 1;
    
    velocity = [0 speed*scaling*direction 0 0];
    % velocity = [0 40 0 0];
    %calculate distance- 1024 slots / 360 deg = 2.844 slots per deg
    slitsPerDeg = 2.844;
    rotationAngle = numOfSlits*slitsPerDeg;
    
    vr = logData(vr, Acol, Bcol, lickPortCol, velocity, timestampCol);

    if (vr.position(2)>=vr.endOftheRoad) 
        velocity(2) = 0;
    end
end
