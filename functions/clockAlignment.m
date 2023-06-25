function vr = clockAlignment(vr)
    % Set the desired length of the column
    columnLength = 200;

    % Generate random sequence lengths
    sequenceLengths = randi([10, 30], columnLength, 1);

    % Create the random column
    randomColumn = zeros(columnLength, 1);
    currentIdx = 1;
    for i = 1:columnLength
        sequenceLength = sequenceLengths(i);
        randomColumn(currentIdx : currentIdx+sequenceLength-1) = randi([0, 1]);
        currentIdx = currentIdx + sequenceLength;
    end

    % Truncate the column to the desired length
    randomColumn = randomColumn(1:columnLength);
    
    %output the data
    vr.ao.queueOutputData(randomColumn);
    startBackground(vr.ao);
end