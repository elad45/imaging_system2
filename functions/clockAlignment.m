function vr = clockAlignment(vr, length)
    % Set the desired length of the column
    global dataFromDAQ;
    timestampCol = dataFromDAQ(:,4);

    % Generate random sequence lengths
    sequenceLengths = randi([10, 20], length, 1);

    % Create the random column
    randomColumn = zeros(length, 1);
    currentIdx = 1;
    for i = 1:length
        sequenceLength = sequenceLengths(i);
        randomColumn(currentIdx : currentIdx+sequenceLength-1) = randi([0, 1]);
        currentIdx = currentIdx + sequenceLength;
    end

    % Truncate the column to the desired length
    randomColumn = randomColumn(1:length);
    zero_data_analog = zeros(length,1);

    %output the data
    vr.ao.queueOutputData([zero_data_analog randomColumn]);
    startBackground(vr.ao);
    %write to log file
    timecol = cat(1,timestampCol,zeros(length-200, 1));
    matrix = [timecol.';randomColumn.'] ;
    fwrite(vr.fid4, matrix,'double');
end

