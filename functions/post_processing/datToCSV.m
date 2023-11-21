function datToCSV(pathToDirectory)

    time_of_trials(pathToDirectory);

    A_B_lickport_fd = fopen(strcat(pathToDirectory, "\A-B_leakport_record.dat")); 
    A_B_lickport_data = fread(A_B_lickport_fd,[4 inf], 'double');
    A_B_lickport_data = A_B_lickport_data';
    columnHeaders1 = {'timestamp', 'A_signal', 'B_signal', 'lickport_signal'};  
    A_B_lickport_Datatable = array2table(A_B_lickport_data, 'VariableNames', columnHeaders1);
    writetable(A_B_lickport_Datatable, strcat(pathToDirectory, "\A-B_leakport_record.csv"));
    fclose(A_B_lickport_fd);

    Reward_fd = fopen(strcat(pathToDirectory, "\Reward.dat"));
    Reward_data = fread(Reward_fd,[2 inf], 'double');
    Reward_data = Reward_data';
    columnHeaders2 = {'timestamp', 'Reward_Given'}; 
    if size(Reward_data) ~= [0 0]
        Reward_Datatable = array2table(Reward_data, 'VariableNames', columnHeaders2);
        writetable(Reward_Datatable, strcat(pathToDirectory, "\Reward.csv"));
    else
        csvwrite(strcat(pathToDirectory, "\Reward.csv"), []);
    end
    fclose(Reward_fd);

    sync_signal_fd = fopen(strcat(pathToDirectory, "\sync_signal.dat"));
    sync_signal_data = fread(sync_signal_fd,[2 inf], 'double');
    sync_signal_data = sync_signal_data';
    columnHeaders3 = {'timestamp', 'Random_signal'}; 
    sync_signal_Datatable = array2table(sync_signal_data, 'VariableNames', columnHeaders3);
    writetable(sync_signal_Datatable, strcat(pathToDirectory, "\sync_signal.csv"));
    fclose(sync_signal_fd);

    velocity_fd = fopen(strcat(pathToDirectory, "\velocity.dat"));
    velocity_data = fread(velocity_fd,[4 inf], 'double');
    velocity_data = velocity_data';
    columnHeaders4 = {'timestamp', 'velocity', 'Avg_velocity', 'lickport_signal'}; 
    velocity_data_Datatable = array2table(velocity_data, 'VariableNames', columnHeaders4);
    writetable(velocity_data_Datatable, strcat(pathToDirectory, "\velocity.csv"));
    fclose(velocity_fd);

end

