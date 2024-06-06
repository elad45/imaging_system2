function [pulse_array] = generateSignal(vr,freq)
    % Parameters
    desired_frequency = 10; % Desired frequency in Hz
    sampling_frequency = 4000; % Sampling frequency in Hz
    lightLength = 1; % Duration of the pulse in seconds (example: 5 seconds)

    % Time vector
    t = 0:1/sampling_frequency:lightLength;

    % Generate the rectangular pulse (square wave) with amplitude between 0 and 1
    pulse = 0.5 * (square(2 * pi * desired_frequency * t) + 1);

    % Convert the pulse into an array
    pulse_array = pulse;

    % Display the pulse array
    disp('Pulse Array:');
    disp(pulse_array);

    % Plot the pulse
    figure;
    plot(t, pulse);
    title(['Rectangular Pulse with Frequency = ' num2str(desired_frequency) ' Hz']);
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;

end

