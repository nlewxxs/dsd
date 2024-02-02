close all; % housekeeping

fprintf("test data set 1: (5, 52): %0.5f\n", calculate(5, 52));
fprintf("test data set 2: (0.125, 2041): %0.5f\n", calculate(0.125, 2041));
fprintf("test data set 3: (0.0009765625, 261121): %0.5f\n", calculate(0.00097656255, 261121));

function answer = calculate(step, N)
    array = 0:step:(N-1)*step;
    total = 0;
    for i = 1:length(array)
        total = total + 0.5*array(i) + (array(i)^2)*cos((array(i) - 128)/128);
        % fprintf("array: %0.6f\n", array(i));
    end
    answer = total;
    % display(array);
end
