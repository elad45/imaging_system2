function vr = soundEqualB(vr, requiredVelocity, allowedDeviationInrange, DeviationBetweenSteps, desiredFreq)

    scale = allowedDeviationInrange; %50 in tests
    scaleOutRange = DeviationBetweenSteps;
    %return this line when finish testing
    velocity1 = vr.velocity(2)
     disp("this is "+vr.DeviationBetweenSteps);
    %right,left boudaries for desired speed
    borderR = requiredVelocity + scale;
    borderL = requiredVelocity - scale;
    
    if (vr.position(2)>=vr.endOftheRoad) %if we reach to the end of the hallway
        vr = stopSound(vr);
    %in desired range
    elseif ((velocity1 <= borderR) && (velocity1 >= borderL))
            generateSound(vr,desiredFreq);
    
    %borderR (out of desired range from the right side)
    elseif (velocity1 > borderR)
        if (velocity1< borderR + 1*scaleOutRange)
            generateSound(vr, desiredFreq+200);
        elseif (velocity1< borderR + 2*scaleOutRange)
            generateSound(vr, desiredFreq+400);
        elseif (velocity1< borderR + 3*scaleOutRange)
            generateSound(vr, desiredFreq+600);
        elseif (velocity1< borderR + 4*scaleOutRange)
            generateSound(vr, desiredFreq+800);
        elseif (velocity1< borderR + 5*scaleOutRange)
            generateSound(vr, desiredFreq+1000);
        elseif (velocity1< borderR + 6*scaleOutRange)
            generateSound(vr, desiredFreq+1200);
        elseif (velocity1< borderR + 7*scaleOutRange)
            generateSound(vr, desiredFreq+1400);
        elseif (velocity1< borderR + 8*scaleOutRange)
            generateSound(vr, desiredFreq+1600);
        elseif (velocity1< borderR + 9*scaleOutRange)
            generateSound(vr, desiredFreq+1800);
        elseif (velocity1< borderR + 10*scaleOutRange)
            generateSound(vr, desiredFreq+2000);
        else
%             disp("out of range borderR soundEqualBtest");
        end    
                
    %borderL (out of range from the left side)  
    else
        if (velocity1 > borderL - 1*scaleOutRange)
            generateSound(vr, desiredFreq+200);
        elseif (velocity1> borderL - 2*scaleOutRange)
            generateSound(vr, desiredFreq+400);
        elseif (velocity1> borderL - 3*scaleOutRange)
            generateSound(vr, desiredFreq+600);
        elseif (velocity1> borderL - 4*scaleOutRange)
            generateSound(vr, desiredFreq+800);
        elseif (velocity1> borderL - 5*scaleOutRange)
            generateSound(vr, desiredFreq+1000);
        elseif (velocity1> borderL - 6*scaleOutRange)
            generateSound(vr, desiredFreq+1200);
        elseif (velocity1> borderL - 7*scaleOutRange)
            generateSound(vr, desiredFreq+1400);
        elseif (velocity1> borderL - 8*scaleOutRange)
            generateSound(vr, desiredFreq+1600);
        elseif (velocity1> borderL - 9*scaleOutRange)
            generateSound(vr, desiredFreq+1800);
        elseif (velocity1> borderL - 10*scaleOutRange)
            generateSound(vr, desiredFreq+2000);
        else
%             disp("out of range borderL soundEqualBtest");
        end
        
      
    end
    
end

    
    



