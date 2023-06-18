function vr = miniGUI(vr)

    selectedSoundOptionIndex = 0;
    selectedWorldOptionIndex = 0;

topLeft = 660;
paddingLeft = 70;
paddingLeftForRightCol = 250;
heightLine = 20;
VerticalGap = 20;
lineWidth = 150;
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
    dropdownSoundOptions = {'Preferred speed', 'Gradual symmetrical tones', 'Gradual asymmetrical tones'};
    dropdownWorldOptions = {'Stripes','World 2', 'Checkers'};
    % Create a figure window and set its size and position
    fig = figure('Position', [550, 250, 500, 700]);
    % Set the CloseRequestFcn callback function
    set(fig, 'CloseRequestFcn', @closeFigureCallback,'Name', 'Session Settings','NumberTitle', 'off');
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
    uicontrol('Style', 'text', 'String', 'Number of trials:', 'Position', [paddingLeft, topLeft, lineWidth, heightLine]);
    sliderAmountTrials = uicontrol('Style', 'slider', 'Position', [paddingLeft, topLeft-1*VerticalGap, lineWidth, heightLine], 'Min', 0, 'Max', 500, 'Value', str2double(dict('db_amount_trials')), 'SliderStep', [0.002 0.1], 'Callback', @sliderAmountTrialsCallback);
    sliderAmountTrialsText = uicontrol('Style', 'text', 'Position', [paddingLeft, topLeft-2*VerticalGap, lineWidth, heightLine], 'String', ['Slider Value: ', dict('db_amount_trials')]);

    function sliderAmountTrialsCallback(source, event)
       selectedSliderAmountTrials = round(get(sliderAmountTrials, 'Value'));
       %changes in gui
       set(sliderAmountTrialsText, 'String', sprintf('Slider Value: %d', selectedSliderAmountTrials));
    end
    
    %percentage threshold to open leakport small reward
    uicontrol('Style', 'text', 'String', '% correct for small reward:', 'Position', [paddingLeft, topLeft-3*VerticalGap, lineWidth, heightLine]);
    sliderPercentageThresholdSmall = uicontrol('Style', 'slider', 'Position', [paddingLeft, topLeft-4*VerticalGap, lineWidth, heightLine], 'Min', 0, 'Max', 100, 'Value', str2double(dict('db_threshold_open_valve_small')), 'SliderStep', [0.01 0.1], 'Callback', @sliderPercentageThresholdSmallCallback);
    sliderPercentageThresholdSmallText = uicontrol('Style', 'text', 'Position', [paddingLeft, topLeft-5*VerticalGap, lineWidth, heightLine], 'String', ['Slider Value: ', dict('db_threshold_open_valve_small')]);
   
    function sliderPercentageThresholdSmallCallback(source, event)
       selectedSliderPercentageThresholdSmall = round(get(sliderPercentageThresholdSmall, 'Value'));
       %changes in gui
       set(sliderPercentageThresholdSmallText, 'String', sprintf('Slider Value: %d', selectedSliderPercentageThresholdSmall));
    end
    
    %percentage threshold to open leakport big reward
    uicontrol('Style', 'text', 'String', '% correct for large reward:', 'Position', [paddingLeftForRightCol, topLeft-3*VerticalGap, lineWidth, heightLine]);
    sliderPercentageThresholdBig = uicontrol('Style', 'slider', 'Position', [paddingLeftForRightCol, topLeft-4*VerticalGap, lineWidth, heightLine], 'Min', 0, 'Max', 100, 'Value', str2double(dict('db_threshold_open_valve_big')), 'SliderStep', [0.01 0.1], 'Callback', @sliderPercentageThresholdBigCallback);
    sliderPercentageThresholdBigText = uicontrol('Style', 'text', 'Position', [paddingLeftForRightCol, topLeft-5*VerticalGap, lineWidth, heightLine], 'String', ['Slider Value: ', dict('db_threshold_open_valve_big')]);
   
    function sliderPercentageThresholdBigCallback(source, event)
       selectedSliderPercentageThresholdBig = round(get(sliderPercentageThresholdBig, 'Value'));
       %changes in gui
       set(sliderPercentageThresholdBigText, 'String', sprintf('Slider Value: %d', selectedSliderPercentageThresholdBig));
    end
    
    
    
    %how long to open the valve Small
    uicontrol('Style', 'text', 'String', 'Valve opening time (ms)', 'Position', [paddingLeft, topLeft-6*VerticalGap, lineWidth, heightLine]); 
        uicontrol('Style', 'text', 'String', 'small reward:', 'Position', [paddingLeft, topLeft-6.7*VerticalGap, lineWidth, heightLine]);    

    % Create a slider control for leakport break
    sliderValveDurationSmall = uicontrol('Style', 'slider', 'Position', [paddingLeft, topLeft-7.5*VerticalGap, lineWidth, heightLine], 'Min', 0, 'Max', 100, 'Value', str2double(dict('db_reward_duration_small')), 'SliderStep', [0.01 0.1], 'Callback', @sliderValveDurationSmallCallback);
    sliderValveDurationSmallText = uicontrol('Style', 'text', 'Position', [paddingLeft, topLeft-8.5*VerticalGap, lineWidth, heightLine], 'String', ['Slider Value: ', dict('db_reward_duration_small')]);

    function sliderValveDurationSmallCallback(source, event)
       selectedSliderLeakportSmallValue = round(get(sliderValveDurationSmall, 'Value'));
       %changes in gui
       set(sliderValveDurationSmallText, 'String', sprintf('Slider Value: %d', selectedSliderLeakportSmallValue));
    end
    
    %how long to open the valve Big
    uicontrol('Style', 'text', 'String', 'Valve opening time (ms)', 'Position', [paddingLeftForRightCol, topLeft-6*VerticalGap, lineWidth, heightLine]);    
    uicontrol('Style', 'text', 'String', 'large reward:', 'Position', [paddingLeftForRightCol, topLeft-6.7*VerticalGap, lineWidth, heightLine]);    

    % Create a slider control for leakport break
    sliderValveDurationBig = uicontrol('Style', 'slider', 'Position', [paddingLeftForRightCol, topLeft-7.5*VerticalGap, lineWidth, heightLine], 'Min', 0, 'Max', 100, 'Value', str2double(dict('db_reward_duration_big')), 'SliderStep', [0.01 0.1], 'Callback', @sliderValveDurationBigCallback);
    sliderValveDurationBigText = uicontrol('Style', 'text', 'Position', [paddingLeftForRightCol, topLeft-8.5*VerticalGap, lineWidth, heightLine], 'String', ['Slider Value: ', dict('db_reward_duration_big')]);

    function sliderValveDurationBigCallback(source, event)
       selectedSliderLeakportBigValue = round(get(sliderValveDurationBig, 'Value'));
       %changes in gui
       set(sliderValveDurationBigText, 'String', sprintf('Slider Value: %d', selectedSliderLeakportBigValue));
    end
    
 

    %choose sound - opens dropdown options list to choose sound from
    uicontrol('Style', 'text', 'String', 'Auditory feedback paradigm:', 'Position', [paddingLeft, topLeft-9.5*VerticalGap, lineWidth, heightLine]);
    dropdownSound = uicontrol('Style', 'popupmenu', 'String', dropdownSoundOptions, 'Position', [paddingLeft, topLeft-10.5*VerticalGap, lineWidth, heightLine]);
    % Set the default choice
    defaultChoiceIndex = str2double(dict('db_sound_option'));  % Set the index of the desired default choice
    set(dropdownSound, 'Value', defaultChoiceIndex);

    %Distance to run
    uicontrol('Style', 'text', 'String', 'Track length (cm):', 'Position', [paddingLeftForRightCol, topLeft-9.5*VerticalGap, lineWidth, heightLine]);
    sliderDistanceToRun = uicontrol('Style', 'slider', 'Position', [paddingLeftForRightCol, topLeft-10.5*VerticalGap, lineWidth, heightLine], 'Min', 0, 'Max', 600, 'Value', str2double(dict('db_distance_to_run')), 'SliderStep', [0.002 0.1], 'Callback', @sliderDistanceToRunCallback);
    sliderDistanceToRunText = uicontrol('Style', 'text', 'Position', [paddingLeftForRightCol, topLeft-11.5*VerticalGap, lineWidth, heightLine], 'String', ['Slider Value: ', dict('db_distance_to_run')]);
   
    function sliderDistanceToRunCallback(source, event)
       selectedSliderDistanceToRunText = round(get(sliderDistanceToRun, 'Value'));
       %changes in gui
       set(sliderDistanceToRunText, 'String', sprintf('Slider Value: %d', selectedSliderDistanceToRunText));
    end
    %choose world
    uicontrol('Style', 'text', 'String', 'World of large reward:', 'Position', [paddingLeft, topLeft-12*VerticalGap, lineWidth, heightLine]);
    dropdownWorld = uicontrol('Style', 'popupmenu', 'String', dropdownWorldOptions, 'Position', [paddingLeft, topLeft-12.8*VerticalGap, lineWidth, heightLine]);
    % Set the default choice
    defaultChoiceIndexWorld = str2double(dict('db_world_option'));  % Set the index of the desired default choice
    set(dropdownWorld, 'Value', defaultChoiceIndexWorld);
    %how long in leak port room
    uicontrol('Style', 'text', 'String', 'Reward room duration (s):', 'Position', [paddingLeft, topLeft-14*VerticalGap, lineWidth, heightLine]);    
    % Create a slider control for leakport break
    sliderLeakport = uicontrol('Style', 'slider', 'Position', [paddingLeft, topLeft-15*VerticalGap, lineWidth, heightLine], 'Min', 0, 'Max', 100, 'Value', str2double(dict('db_leakport_room_break')), 'SliderStep', [0.01 0.1], 'Callback', @sliderLeakportCallback);
    sliderValueLeakportText = uicontrol('Style', 'text', 'Position', [paddingLeft, topLeft-16*VerticalGap, lineWidth, heightLine], 'String', ['Slider Value: ', dict('db_leakport_room_break')]);

    function sliderLeakportCallback(source, event)
       selectedSliderLeakportValue = round(get(sliderLeakport, 'Value'));
       %changes in gui
       set(sliderValueLeakportText, 'String', sprintf('Slider Value: %d', selectedSliderLeakportValue));
    end
 
    %create a slider control for black room break
    uicontrol('Style', 'text', 'String', 'Inter trial interval (s)', 'Position', [paddingLeft, topLeft-17*VerticalGap, lineWidth, heightLine]);
    sliderBlackroom = uicontrol('Style', 'slider', 'Position', [paddingLeft, topLeft-18*VerticalGap, lineWidth, heightLine], 'Min', 0, 'Max', 100, 'Value', str2double(dict('db_black_room_break')), 'SliderStep', [0.01 0.1], 'Callback', @sliderBlackRoomCallback);
    sliderValueBlackRoomText = uicontrol('Style', 'text', 'Position', [paddingLeft, topLeft-19*VerticalGap, lineWidth, heightLine], 'String', ['Slider Value: ', dict('db_black_room_break')]);
   
    function sliderBlackRoomCallback(source, event)
       selectedSliderBlackRoomValue = round(get(sliderBlackroom, 'Value'));
       %changes in gui
       set(sliderValueBlackRoomText, 'String', sprintf('Slider Value: %d', selectedSliderBlackRoomValue));
    end
    
    %target speed
    %create a slider control for target speed
    uicontrol('Style', 'text', 'String', 'Preferred speed (cm/s):', 'Position', [paddingLeft, topLeft-20*VerticalGap, lineWidth, heightLine]);
    sliderTargetSpeed = uicontrol('Style', 'slider', 'Position', [paddingLeft, topLeft-21*VerticalGap, lineWidth, heightLine], 'Min', 0, 'Max', 100, 'Value', str2double(dict('db_target_speed')), 'SliderStep', [0.01 0.1], 'Callback', @sliderTargetSpeedCallback);
    sliderValueTargetSpeedText = uicontrol('Style', 'text', 'Position', [paddingLeft, topLeft-22*VerticalGap, lineWidth, heightLine], 'String', ['Slider Value: ', dict('db_target_speed')]);
   
 
    %deviation
     %create a slider control for deviation from target sound,it is  the stair of the good range
    uicontrol('Style', 'text', 'String', 'Preferred speed deviation (cm/s):', 'Position', [paddingLeft-10, topLeft-23*VerticalGap, lineWidth+30, heightLine]);
    sliderDeviation = uicontrol('Style', 'slider', 'Position', [paddingLeft, topLeft-24*VerticalGap, lineWidth, heightLine], 'Min', 0, 'Max', 100, 'Value', str2double(dict('db_sound_deviation_in_range')), 'SliderStep', [0.01 0.1], 'Callback', @sliderDeviationCallback);
    sliderValueDeviationText = uicontrol('Style', 'text', 'Position', [paddingLeft, topLeft-25*VerticalGap, lineWidth, heightLine], 'String', ['Slider Value: ', dict('db_sound_deviation_in_range')]);
   
    function sliderDeviationCallback(source, event)
       selectedSliderDevValue = round(get(sliderDeviation, 'Value'));
       %changes in gui
       set(sliderValueDeviationText, 'String', sprintf('Slider Value: %d', selectedSliderDevValue));
    end
 

    function sliderTargetSpeedCallback(source, event)
       selectedSliderTargetSpeedValue = round(get(sliderTargetSpeed, 'Value'));
       %changes in gui
       set(sliderValueTargetSpeedText, 'String', sprintf('Slider Value: %d', selectedSliderTargetSpeedValue));
    end
 
    %stair deviation of sound out of range
    uicontrol('Style', 'text', 'String', 'Speed step size:', 'Position', [paddingLeft, topLeft-26*VerticalGap, lineWidth, heightLine]);
    sliderDeviationOutOfRange = uicontrol('Style', 'slider', 'Position', [paddingLeft, topLeft-27*VerticalGap, lineWidth, heightLine], 'Min', 0, 'Max', 100, 'Value', str2double(dict('db_sound_deviation_out_range')), 'SliderStep', [0.01 0.1], 'Callback', @sliderDeviationOutOfRangeCallback);
    sliderValueDeviationOutOfRangeText = uicontrol('Style', 'text', 'Position', [paddingLeft, topLeft-28*VerticalGap, lineWidth, heightLine], 'String', ['Slider Value: ', dict('db_sound_deviation_out_range')]);
   
    function sliderDeviationOutOfRangeCallback(source, event)
       selectedSliderDevOutOfRangeValue = round(get(sliderDeviationOutOfRange, 'Value'));
       %changes in gui
       set(sliderValueDeviationOutOfRangeText, 'String', sprintf('Slider Value: %d', selectedSliderDevOutOfRangeValue));
    end


    % Create a button to display the selected option from the dropdown list
    paddingBottom = 50;
    buttonWidth = 100;
    paddingLeft = 187;
    button = uicontrol('Style', 'pushbutton', 'String', 'Select', 'Position', [paddingLeft, paddingBottom, buttonWidth, heightLine*1.5], 'Callback', @buttonCallback);

   
    % Define a callback function for the button
    function buttonCallback(source, event)
        % Get the selected option from the dropdown list
        %sound
        selectedSoundOptionIndex = round(get(dropdownSound, 'Value'));
        vr.soundProfile = selectedSoundOptionIndex;
        
        %world to be the big reward, the other one is th small reward by default
        selectedWorldOptionIndex = round(get(dropdownWorld,'Value'));
      
        vr.chosenWorldToBeBigReward  = selectedWorldOptionIndex;

        %leakport break
        vr.leakportBreak = round(get(sliderLeakport, 'Value'));
        
        %Black Room break;
        vr.blackRoomBreak = round(get(sliderBlackroom, 'Value'));
        
        %deviation allowed
        vr.allowedDeviation = round(get(sliderDeviation, 'Value'));
        
        %deviation out of range for sound B and C
        vr.DeviationBetweenSteps = round(get(sliderDeviationOutOfRange, 'Value'));
        
        %target speed
        vr.targetSpeed = round(get(sliderTargetSpeed, 'Value'));
        
        %reward duration small
        vr.rewardDurationSmall = round(get(sliderValveDurationSmall, 'Value'));
        
        %reward duration big
        vr.rewardDurationBig = round(get(sliderValveDurationBig, 'Value'));
        
        %distance to run
        vr.distanceToRun = round(get(sliderDistanceToRun, 'Value')*vr.meterTovirmenUnits);
        
        %Percentage threshold to open leakport Small
        vr.percentageThresholdSmall = round(get(sliderPercentageThresholdSmall, 'Value'));
        
        %Percentage threshold to open leakport Big
        vr.percentageThresholdBig = round(get(sliderPercentageThresholdBig, 'Value'));
        %amount of trials
        vr.amountTrials = round(get(sliderAmountTrials, 'Value'));
        %we want to continue to run
        vr.isSessionRun = true;
        %close(fig);
        closeFigureCallback();
        
    end
   waitfor(fig);

end

