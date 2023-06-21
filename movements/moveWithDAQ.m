function velocity = moveWithDAQ(vr)
    %vr = calculateAvgSpeed(vr);

    velocity = [0 vr.avgVelocity 0 0];
    %velocity = [0 40 0 0];
    
    %vr = logData(vr, Acol, Bcol, lickPortCol, velocity, timestampCol);

    if (vr.position(2)>=vr.endOftheRoad) 
        velocity(2) = 0;
    end
end