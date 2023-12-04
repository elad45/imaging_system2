function vr = logData(vr, Acol, Bcol, lickPortCol, velocityCurr, velocityAvg, timestampCol)
    %log velocity and lickport
%     timestamp = clock;
    fwrite(vr.fid1, [timestampCol(1) velocityCurr velocityAvg round(lickPortCol(1)) vr.countTrials],'double');

    %log a,b,lickport
    trial_num_column = vr.countTrials * ones(size(Bcol,1), 1);

    matrix = [timestampCol(2:2:end).';Acol(2:2:end).';Bcol(2:2:end).';lickPortCol(2:2:end).';trial_num_column(2:2:end).'] ;
    fwrite(vr.fid2, matrix,'double');

end

