% Simulation of CORDIC
% Nik Lewis, CID 02031260

close all;
format long;

% Parameters to be tweaked to fit specification
% Takes input as fixed-point number
% for i = 1:numel(alphas)
%     fprintf("%.30f\n", alphas(i));
% end

% inits
% fprintf("Starting values: \tx0 = %.20f, y0 = %.20f, z0 = %.20f\n", x0, y0, z0);
% [x, ~, ~] = do_cordic(x0, y0, z0, PARAM_N_ITERATIONS, alphas, PARAM_DEBUG_CORDIC_OUTPUT);
% fprintf("True value: %.20f, Error: %.20f\n", cos(PARAM_TEST_ANGLE), abs(double(x)-cos(PARAM_TEST_ANGLE)));

% foo = monte_carlo(100);

foo = calculate(1/1024.0, 261121);
display(foo);

function answer = calculate(step, N)
    array = 0:step:(N-1)*step;
    total = 0;
	PARAM_WORD_LENGTH = 21; % 24 bit total wordlength extracted from FP->fixed conversion
	PARAM_FRACTION_LENGTH = 19; % 23 of these are fractional bits by default
	PARAM_N_ITERATIONS = 17; % number of cordic iterations
	PARAM_TEST_ANGLE = 0.125; % test angle z0 in radians
	PARAM_DEBUG_CORDIC_OUTPUT = 0;
	PARAM_FIXED_POINT = 1;

	alphas = calculate_alpha(PARAM_N_ITERATIONS, PARAM_FIXED_POINT, PARAM_WORD_LENGTH, PARAM_FRACTION_LENGTH);

    	for i = 1:length(array)

	iteration_idxs = 0:1:PARAM_N_ITERATIONS-1;
	K = prod(sqrt(1 + 2.^(-2*(iteration_idxs))));
	if (PARAM_FIXED_POINT == 1); x0 = fi(1/K, true, PARAM_WORD_LENGTH, PARAM_FRACTION_LENGTH); else; x0 = 1/K; end
	if (PARAM_FIXED_POINT == 1); y0 = fi(0, true, PARAM_WORD_LENGTH, PARAM_FRACTION_LENGTH); else; y0 = 0; end
	if (PARAM_FIXED_POINT == 1); z0 = fi(array(i), true, PARAM_WORD_LENGTH, PARAM_FRACTION_LENGTH); else; z0 = PARAM_TEST_ANGLE; end

	angle = (array(i) - 128)/128;
	[cosres, ~, ~] = do_cordic(x0, y0, z0, PARAM_N_ITERATIONS, alphas, PARAM_DEBUG_CORDIC_OUTPUT);
        total = total + 0.5*array(i) + (array(i)^2)*cos((array(i) - 128)/128);
        % fprintf("array: %0.6f\n", array(i));
    end
    answer = total;
    % display(array);
end

%fprintf("decimal value: %.20f\n", decimal);

function results = monte_carlo(samples)
    % vary the number of iterations and the wordlength.
    iterations_ub = 25; % upper bound for number of cordic iterations
    iterations_lb = 5; % lower bound for number of cordic iterations
    wordlength_ub = 2; % upper bound for wordlength
    wordlength_lb = 2; % lower bound for wordlength

    % init results array, cell to allow tuples.
    results = cell(wordlength_ub - wordlength_lb, iterations_ub - iterations_lb);

    for wordlength = wordlength_lb:wordlength_ub
        % time duration analysis
        if (wordlength == wordlength_lb) tic; end
        if (wordlength == wordlength_lb + 1)
            elapsed = toc;
            fprintf("*** ESTIMATED TIME TO COMPLETION: %s HOURS ***\n", num2str(hours(seconds(elapsed*(wordlength_ub - wordlength_lb)))));
        end

        fprintf("Wordlength: %d / %d\n", wordlength, wordlength_ub);
        for iterations = iterations_lb:iterations_ub
            % fprintf("\tIteration: %d / %d\n", iterations, iterations_ub);
            % generate input angles, all in range -1 to 1
            thetas = -1 + (2 * rand(1, samples));
            % calculate double precision results before fixed-point conversion
            true_values = cos(thetas);
            % calculate K and trig values based on number of iterations
            iteration_idxs = 0:1:iterations-1;
            K = prod(sqrt(1 + 2.^(-2*(iteration_idxs))));
            alphas = calculate_alpha(iterations, wordlength, wordlength-2);

            % Perform monte carlo simulation for some N number of samples
            for i = 1:samples
                % set starting values
                x0 = fi(1/K, true, wordlength, wordlength-2);
                y0 = fi(0, true, wordlength, wordlength-2);
                z0 = fi(thetas(i), true, wordlength, wordlength-2);
                % call cordic but only keep the cos answer
                [x, ~, ~] = do_cordic(x0, y0, z0, iterations, alphas, 0);
                cordic_results(i) = x;
            end

            % post-processing
            % calculate error
            e = double(cordic_results) - true_values;
            % mean error
            mean_e = sum(e) / samples;
            % lower and upper end points using z-value corresponding to 95% confidence interval
            lower_ep = mean_e - 1.96*std(e)/sqrt(samples);
            upper_ep = mean_e + 1.96*std(e)/sqrt(samples);
            interval = [lower_ep, upper_ep];
            % store error interval (account for array indexing)
            fprintf("For wordlength: %d, iterations: %d, res: [%.20f, %.20f]\n", wordlength, iterations, lower_ep, upper_ep);
            results{wordlength - (wordlength_lb - 1), iterations - (iterations_lb - 1)} = interval;
        end
    end
    save("monte-carlo.mat", 'results');
end

function [x, y, z] = do_cordic(x0, y0, z0, N, alphas, PARAM_DEBUG_CORDIC_OUTPUT)
    % init
    x = x0;
    y = y0;
    z = z0;
    for iteration = 1:1:N
        [x, y, z] = cordic_iteration(x, y, z, iteration, alphas);
        if (PARAM_DEBUG_CORDIC_OUTPUT == 1)
            fprintf("--------\nAfter iteration %d:\n x = %.20f, z = %.20f\n Used alpha = %.20f\n", iteration, x, z, alphas(iteration));
        end
    end
end

% xi, yi, zi - current values
% i - iteration number, starting from 0
function [x, y, z] = cordic_iteration(x, y, z, i, alphas)
    % first op - lookup
    % display(alphas);
    alpha = fi(alphas(i), true, 21, 19); % note matlab uses 1-based indexing
    % perform bitshifts with bitsra since it preserves the sign bit
    x_s = bitsra(x, i-1);
    y_s = bitsra(y, i-1);
    % update x and y
    x(:) = x - sign(z)*y_s;
    y(:) = y + sign(z)*x_s;
    z(:) = z - sign(z)*alpha;
end

function alpha = calculate_alpha(N, fixed, wordLength, fractionLength)
    alpha = zeros(1, N);
    for i = 1:1:N
        atanvalue = atan(2^-(i-1));
        if (fixed == 1)
            alpha(i) = fi(atanvalue, true, wordLength, fractionLength);
        else
            alpha(i) = atanvalue;
        end
    end
end

