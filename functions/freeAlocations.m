function vr = freeAlocations(vr)
    vr = stopSound(vr);
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
    fclose(vr.fid4);
    fclose(vr.fid5);
    
    % Command to stop the Node.js server (assuming you want to forcefully kill the process)
    stopCommand = 'taskkill /F /IM node.exe';
    system(stopCommand);
end

