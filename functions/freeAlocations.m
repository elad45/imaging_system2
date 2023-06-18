function vr = freeAlocations(vr)
    delete(vr.t1);
    delete(vr.t2);
    % remove the listener
    delete(vr.lh1);
    % stop the DAQ session
    stop(vr.ai);
    stop(vr.ao);
    % close the files
    fclose(vr.fid1);
    fclose(vr.fid2);
    fclose(vr.fid3);
end

