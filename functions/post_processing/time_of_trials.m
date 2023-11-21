function time_of_trials(pathToDirectory)
    TrialTimeline_fd = fopen(strcat(pathToDirectory, "\TrialTimeline.dat"));
    trialData = fread(TrialTimeline_fd,[3 inf], 'double');
    newCol = [0;0;5];
    trialData = [newCol trialData];
    trialData = trialData';
    % Find the rows where the third column has the value 5
    rowsWithFive = trialData(:, 3) == 5;

    % Extract the rows with the third column equal to 5
    resultMatrix = trialData(rowsWithFive, :);

    columnHeaders = {'timestamp', 'trialnum', 'newTrialStart'};  % Replace with your actual header names
    trialDatatable = array2table(resultMatrix, 'VariableNames', columnHeaders);

    writetable(trialDatatable, strcat(pathToDirectory, "\TrialTimeline.csv"));
    fclose(TrialTimeline_fd);
end
