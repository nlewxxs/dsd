close all; % housekeeping

task2ans = calculate_task2(5, 52);
fprintf("test data set 1: (5, 52): %0.5f\n", calculate_task2(5, 52));
fprintf("test data set 2: (0.125, 2041): %0.5f\n", calculate_task2(0.125, 2041));

function answer = calculate_task2(step, N)
    array = 0:step:N*step-1;
    total = 0;
    for i = 1:length(array)
        total = total + array(i) + array(i)^2;
    end
    answer = total;
end
