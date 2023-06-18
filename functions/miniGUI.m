function vr = miniGUI(vr)

    selectedSoundOptionIndex = 0;
    selectedWorldOptionIndex = 0;

topLeft = 660;
paddingLeft = 70;
paddingLeftForRightCol = 250;
heightLine = 20;
VerticalGap = 20;   
% Read the JSON file
jsonStr = fileread(vr.configToLoadOnGui);

% Decode the JSON string
jsonData = jsondecode(jsonStr);

% Create a dictionary-like structure
dict = containers.Map;

% Iterate over the fields in the JSON data and populate the dictionary
fields = fieldnames(jsonData);
for i = 1:numel(fields)
    field = fields{i};
    dict(field) = jsonData.(field);
end
   
    %%%%%%%%%%%%%%%%%%%%
    % Create a cell array of options for the dropdown list
    dropdownSoundOptions = {'contenious sound', 'adjustable sound(same in both directions)', 'adjustable sound(asymetric in both directions)'};
    dropdownWorldOptions = {'Stripes','World 2', 'Checkers'};
    % Create a figure window and set its size and position
    fig = figure('Position', [550, 250, 500, 700]);
    % Set the CloseRequestFcn callback function
    set(fig, 'CloseRequestFcn', @closeFigureCallback);
    % Close Request Callback function
    function closeFigureCallback(~, ~)
        % Perform the desired action when the figure is closed
        disp('Figure closed. Performing action...');
        delete(fig);
        %this is the case we clicked on the X buton for exit
        if vr.isSessionRun == false
            vr.experimentEnded = true;
        end
        % Add your code here to perform the desired action
        % For example, you can save data or display a message
    end
    
    %amount of trials in a session
    uicontrol('Style', 'text', 'String', 'Amount of trials:', 'Position', [paddingLeft, topLeft, 150, heightLine]);
    sliderAmountTrials = uicontrol('Style', 'slider', 'Position', [paddingLeft, topLeft-1*VerticalGap, 150, heightLine], 'Min', 0, 'Max', 500, 'Value', str2double(dict('db_amount_trials')), 'SliderStep', [0.002 0.1], 'Callback', @sliderAmountTrialsCallback);
    sliderAmountTrialsText = uicontrol('Style', 'text', 'Position', [paddingLeft, topLeft-2*VerticalGap, 150, heightLine], 'String', ['Slider Value: ', dict('db_amount_trials')]);

    function sliderAmountTrialsCallback(source, event)
       selectedSliderAmountTrials = round(get(sliderAmountTrials, 'Value'));
       %changes in gui
       set(sliderAmountTrialsText, 'String', sprintf('Slider Value: %d', selectedSliderAmountTrials));
    end
    
    %percentage threshold to open leakport small reward
    uicontrol('Style', 'text', 'String', 'Threshold for leakport small:', 'Position', [paddingLeft, topLeft-3*VerticalGap, 150, heightLine]);
    sliderPercentageThresholdSmall = uicontrol('Style', 'slider', 'Position', [paddingLeft, topLeft-4*VerticalGap, 150, heightLine], 'Min', 0, 'Max', 100, 'Value', str2double(dict('db_threshold_open_valve_small')), 'SliderStep', [0.01 0.1], 'Callback', @sliderPercentageThresholdSmallCallback);
    sliderPercentageThresholdSmallText = uicontrol('Style', 'text', 'Position', [paddingLeft, topLeft-5*VerticalGap, 150, heightLine], 'String', ['Slider Value: ', dict('db_threshold_open_valve_small')]);
   
    function sliderPercentageThresholdSmallCallback(source, event)
       selectedSliderPercentageThresholdSmall = round(get(sliderPercentageThresholdSmall, 'Value'));
       %changes in gui
       set(sliderPercentageThresholdSmallText, 'String', sprintf('Slider Value: %d', selectedSliderPercentageThresholdSmall));
    end
    
    %percentage threshold to open leakport big reward
    uicontrol('Style', 'text', 'String', 'Threshold for leakport big:', 'Position', [paddingLeftForRightCol, topLeft-3*VerticalGap, 150, heightLine]);
    sliderPercentageThresholdBig = uicontrol('Style', 'slider', 'Position', [paddingLeftForRightCol, topLeft-4*VerticalGap, 150, heightLine], 'Min', 0, 'Max', 100, 'Value', str2double(dict('db_threshold_open_valve_big')), 'SliderStep', [0.01 0.1], 'Callback', @sliderPercentageThresholdBigCallback);
    sliderPercentageThresholdBigText = uicontrol('Style', 'text', 'Position', [paddingLeftForRightCol, topLeft-5*VerticalGap, 150, heightLine], 'String', ['Slider Value: ', dict('db_threshold_open_valve_big')]);
   
    function sliderPercentageThresholdBigCallback(source, event)
       selectedSliderPercentageThresholdBig = round(get(sliderPercentageThresholdBig, 'Value'));
       %changes in gui
       set(sliderPercentageThresholdBigText, 'String', sprintf('Slider Value: %d', selectedSliderPercentageThresholdBig));
    end
    
    
    
    %how long to open the valve Small
    uicontrol('Style', 'text', 'String', 'reward duration Small (ms):', 'Position', [paddingLeft, topLeft-6*VerticalGap, 150, heightLine]);    
    % Create a slider control for leakport break
    sliderValveDurationSmall = uicontrol('Style', 'slider', 'Position', [paddingLeft, topLeft-7*VerticalGap, 150, heightLine], 'Min', 0, 'Max', 1000, 'Value', str2double(dict('db_reward_duration_small')), 'SliderStep', [0.01 0.1], 'Callback', @sliderValveDurationSmallCallback);
    sliderValveDurationSmallText = uicontrol('Style', 'text', 'Position', [paddingLeft, topLeft-8*VerticalGap, 150, heightLine], 'String', ['Slider Value: ', dict('db_reward_duration_small')]);

    function sliderValveDurationSmallCallback(source, event)
       selectedSliderLeakportSmallValue = round(get(sliderValveDurationSmall, 'Value'));
       %changes in gui
       set(sliderValveDurationSmallText, 'String', sprintf('Slider Value: %d', selectedSliderLeakportSmallValue));
    end
    
    %how long to open the valve Big
    uicontrol('Style', 'text', 'String', 'reward duration Big (ms):', 'Position', [paddingLeftForRightCol, topLeft-6*VerticalGap, 150, heightLine]);    
    % Create a slider control for leakport break
    sliderValveDurationBig = uicontrol('Style', 'slider', 'Position', [paddingLeftForRightCol, topLeft-7*VerticalGap, 150, heightLine], 'Min', 0, 'Max', 1000, 'Value', str2double(dict('db_reward_duration_big')), 'SliderStep', [0.01 0.1], 'Callback', @sliderValveDurationBigCallback);
    sliderValveDurationBigText = uicontrol('Style', 'text', 'Position', [paddingLeftForRightCol, topLeft-8*VerticalGap, 150, heightLine], 'String', ['Slider Value: ', dict('db_reward_duration_big')]);

    function sliderValveDurationBigCallback(source, event)
       selectedSliderLeakportBigValue = round(get(sliderValveDurationBig, 'Value'));
       %changes in gui
       set(sliderValveDurationBigText, 'String', sprintf('Slider Value: %d', selectedSliderLeakportBigValue));
    end
    
    %Distance to run
    uicontrol('Style', 'text', 'String', 'Distance to run:', 'Position', [paddingLeftForRightCol, topLeft-9*VerticalGap, 150, heightLine]);
    sliderDistanceToRun = uicontrol('Style', 'slider', 'Position', [paddingLeftForRightCol, topLeft-10*VerticalGap, 150, heightLine], 'Min', 0, 'Max', 600, 'Value', str2double(dict('db_distance_to_run')), 'SliderStep', [0.002 0.1], 'Callback', @sliderDistanceToRunCallback);
    sliderDistanceToRunText = uicontrol('Style', 'text', 'Position', [paddingLeftForRightCol, topLeft-11*VerticalGap, 150, heightLine], 'String', ['Slider Value: ', dict('db_distance_to_run')]);
   
    function sliderDistanceToRunCallback(source, event)
       selectedSliderDistanceToRunText = round(get(sliderDistanceToRun, 'Value'));
       %changes in gui
       set(sliderDistanceToRunText, 'String', sprintf('Slider Value: %d', selectedSliderDistanceToRunText));
    end

    %choose sound - opens dropdown options list to choose sound from
    uicontrol('Style', 'text', 'String', 'Choose a sound option:', 'Position', [paddingLeft, topLeft-9*VerticalGap, 150, heightLine]);
    dropdownSound = uicontrol('Style', 'popupmenu', 'String', dropdownSoundOptions, 'Position', [paddingLeft, topLeft-10*VerticalGap, 150, heightLine]);
    % Set the default choice
    defaultChoiceIndex = str2double(dict('db_sound_option'));  % Set the index of the desired default choice
    set(dropdownSound, 'Value', defaultChoiceIndex);


    %choose world
    uicontrol('Style', 'text', 'String', 'world to be the big reward:', 'Position', [paddingLeft, topLeft-11.5*VerticalGap, 150, heightLine]);
    dropdownWorld = uicontrol('Style', 'popupmenu', 'String', dropdownWorldOptions, 'Position', [paddingLeft, topLeft-12.5*VerticalGap, 150, heightLine]);
    % Set the default choice
    defaultChoiceIndexWorld = str2double(dict('db_world_option'));  % Set the index of the desired default choice
    set(dropdownWorld, 'Value', defaultChoiceIndexWorld);
    %how long in leak port room
    uicontrol('Style', 'text', 'String', 'leak port break:', 'Position', [paddingLeft, topLeft-14*VerticalGap, 150, heightLine]);    
    % Create a slider control for leakport break
    sliderLeakport = uicontrol('Style', 'slider', 'Position', [paddingLeft, topLeft-15*VerticalGap, 150, heightLine], 'Min', 0, 'Max', 100, 'Value', str2double(dict('db_leakport_room_break')), 'SliderStep', [0.01 0.1], 'Callback', @sliderLeakportCallback);
    sliderValueLeakportText = uicontrol('Style', 'text', 'Position', [paddingLeft, topLeft-16*VerticalGap, 150, heightLine], 'String', ['Slider Value: ', dict('db_leakport_room_break')]);

    function sliderLeakportCallback(source, event)
       selectedSliderLeakportValue = round(get(sliderLeakport, 'Value'));
       %changes in gui
       set(sliderValueLeakportText, 'String', sprintf('Slider Value: %d', selectedSliderLeakportValue));
    end
 
    %create a slider control for black room break
    uicontrol('Style', 'text', 'String', 'black room break:', 'Position', [paddingLeft, topLeft-17*VerticalGap, 150, heightLine]);
    sliderBlackroom = uicontrol('Style', 'slider', 'Position', [paddingLeft, topLeft-18*VerticalGap, 150, heightLine], 'Min', 0, 'Max', 100, 'Value', str2double(dict('db_black_room_break')), 'SliderStep', [0.01 0.1], 'Callback', @sliderBlackRoomCallback);
    sliderValueBlackRoomText = uicontrol('Style', 'text', 'Position', [paddingLeft, topLeft-19*VerticalGap, 150, heightLine], 'String', ['Slider Value: ', dict('db_black_room_break')]);
   
    function sliderBlackRoomCallback(source, event)
       selectedSliderBlackRoomValue = round(get(sliderBlackroom, 'Value'));
       %changes in gui
       set(sliderValueBlackRoomText, 'String', sprintf('Slider Value: %d', selectedSliderBlackRoomValue));
    end
    
 
    %deviation
     %create a slider control for deviation from target sound,it is  the stair of the good range
    uicontrol('Style', 'text', 'String', 'deviation from target sound:', 'Position', [paddingLeft, topLeft-20*VerticalGap, 150, heightLine]);
    sliderDeviation = uicontrol('Style', 'slider', 'Position', [paddingLeft, topLeft-21*VerticalGap, 150, heightLine], 'Min', 0, 'Max', 100, 'Value', str2double(dict('db_sound_deviation_in_range')), 'SliderStep', [0.01 0.1], 'Callback', @sliderDeviationCallback);
    sliderValueDeviationText = uicontrol('Style', 'text', 'Position', [paddingLeft, topLeft-22*VerticalGap, 150, heightLine], 'String', ['Slider Value: ', dict('db_sound_deviation_in_range')]);
   
    function sliderDeviationCallback(source, event)
       selectedSliderDevValue = round(get(sliderDeviation, 'Value'));
       %changes in gui
       set(sliderValueDeviationText, 'String', sprintf('Slider Value: %d', selectedSliderDevValue));
    end
 

    %target speed
     %create a slider control for target speed
    uicontrol('Style', 'text', 'String', 'target speed:', 'Position', [paddingLeft, topLeft-23*VerticalGap, 150, heightLine]);
    sliderTargetSpeed = uicontrol('Style', 'slider', 'Position', [paddingLeft, topLeft-24*VerticalGap, 150, heightLine], 'Min', 0, 'Max', 100, 'Value', str2double(dict('db_target_speed')), 'SliderStep', [0.01 0.1], 'Callback', @sliderTargetSpeedCallback);
    sliderValueTargetSpeedText = uicontrol('Style', 'text', 'Position', [paddingLeft, topLeft-25*VerticalGap, 150, heightLine], 'String', ['Slider Value: ', dict('db_target_speed')]);
   
    function sliderTargetSpeedCallback(source, event)
       selectedSliderTargetSpeedValue = round(get(sliderTargetSpeed, 'Value'));
       %changes in gui
       set(sliderValueTargetSpeedText, 'String', sprintf('Slider Value: %d', selectedSliderTargetSpeedValue));
    end
 
    %stair deviation of sound out of range
    uicontrol('Style', 'text', 'String', 'deviation sound out of range:', 'Position', [paddingLeft, topLeft-26*VerticalGap, 150, heightLine]);
    sliderDeviationOutOfRange = uicontrol('Style', 'slider', 'Position', [paddingLeft, topLeft-27*VerticalGap, 150, heightLine], 'Min', 0, 'Max', 100, 'Value', str2double(dict('db_sound_deviation_out_range')), 'SliderStep', [0.01 0.1], 'Callback', @sliderDeviationOutOfRangeCallback);
    sliderValueDeviationOutOfRangeText = uicontrol('Style', 'text', 'Position', [paddingLeft, topLeft-28*VerticalGap, 150, heightLine], 'String', ['Slider Value: ', dict('db_sound_deviation_out_range')]);
   
    function sliderDeviationOutOfRangeCallback(source, event)
       selectedSliderDevOutOfRangeValue = round(get(sliderDeviationOutOfRange, 'Value'));
       %changes in gui
       set(sliderValueDeviationOutOfRangeText, 'String', sprintf('Slider Value: %d', selectedSliderDevOutOfRangeValue));
    end


    % Create a button to display the selected option from the dropdown list
    paddingBottom = 50;
    button = uicontrol('Style', 'pushbutton', 'String', 'Select', 'Position', [187, paddingBottom, 100, heightLine*1.5], 'Callback', @buttonCallback);

   
    % Define a callback function for the button
    function buttonCallback(source, event)
        % Get the selected option from the dropdown list
        %sound
        selectedSoundOptionIndex = get(dropdownSound, 'Value');
        vr.soundProfile = selectedSoundOptionIndex;
        
        %world to be the big reward, the other one is th small reward by default
        selectedWorldOptionIndex = get(dropdownWorld,'Value');
        vr.chosenWorldToBeBigReward  = selectedWorldOptionIndex;

        %leakport break
        vr.leakportBreak = get(sliderLeakport, 'Value');
        
        %Black Room break;
        vr.blackRoomBreak = get(sliderBlackroom, 'Value');
        
        %deviation allowed
        vr.allowedDeviation = get(sliderDeviation, 'Value');
        
        %deviation out of range for sound B and C
        vr.DeviationBetweenSteps = get(sliderDeviationOutOfRange, 'Value');
        
        %target speed
        vr.targetSpeed = get(sliderTargetSpeed, 'Value');
        
        %reward duration small
        vr.rewardDurationSmall = get(sliderValveDurationSmall, 'Value');
        
        %reward duration big
        vr.rewardDurationBig = get(sliderValveDurationBig, 'Value');
        
        %distance to run
        vr.distanceToRun = round(get(sliderDistanceToRun, 'Value'));
        
        %Percentage threshold to open leakport Small
        vr.percentageThresholdSmall = get(sliderPercentageThresholdSmall, 'Value');
        
        %Percentage threshold to open leakport Big
        vr.percentageThresholdBig = get(sliderPercentageThresholdBig, 'Value');
        %amount of trials
        vr.amountTrials = get(sliderAmountTrials, 'Value');
        %we want to continue to run
        vr.isSessionRun = true;
        %close(fig);
        closeFigureCallback();
        
    end
   waitfor(fig);

end

