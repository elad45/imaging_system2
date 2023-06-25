function vr = logData(vr, Acol, Bcol, lickPortCol, velocityCurr, velocityAvg, timestampCol)
    %log velocity
%     timestamp = clock;
    a = [timestampCol(1) velocityCurr(2) round(lickPortCol(1))];
    fwrite(vr.fid1, [timestampCol(1) velocityCurr(2) velocityAvg(2) round(lickPortCol(1))],'double');

    %log a,b,lickport
%     r1 = 0:(vr.ai.NotifyWhenDataAvailableExceeds/2)-1;
    matrix = [timestampCol(2:2:end).';Acol(2:2:end).';Bcol(2:2:end).';lickPortCol(2:2:end).'] ;
    fwrite(vr.fid2, matrix,'double');

end

