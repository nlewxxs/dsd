% Simulation of CORDIC
% Nik Lewis, CID 02031260

close all;
format long;

% Parameters to be tweaked to fit specification
PARAM_WORD_LENGTH = 101; % 24 bit total wordlength extracted from FP->fixed conversion
PARAM_FRACTION_LENGTH = 90; % 23 of these are fractional bits by default
PARAM_N_ITERATIONS = 35; % number of cordic iterations
PARAM_TEST_ANGLE = 0.5; % test angle z0 in radians
PARAM_DEBUG_CORDIC_OUTPUT = 0;
PARAM_FIXED_POINT = 1;

% Takes input as fixed-point number
alphas = calculate_alpha(PARAM_N_ITERATIONS, PARAM_FIXED_POINT, PARAM_WORD_LENGTH, PARAM_FRACTION_LENGTH);

% inits
iteration_idxs = 0:1:PARAM_N_ITERATIONS-1;
K = prod(sqrt(1 + 2.^(-2*(iteration_idxs))));
if (PARAM_FIXED_POINT == 1); x0 = fi(1/K, true, PARAM_WORD_LENGTH, PARAM_FRACTION_LENGTH); else; x0 = 1/K; end
if (PARAM_FIXED_POINT == 1); y0 = fi(0, true, PARAM_WORD_LENGTH, PARAM_FRACTION_LENGTH); else; y0 = 0; end
if (PARAM_FIXED_POINT == 1); z0 = fi(PARAM_TEST_ANGLE, true, PARAM_WORD_LENGTH, PARAM_FRACTION_LENGTH); else; z0 = PARAM_TEST_ANGLE; end

% fprintf("Starting values: \tx0 = %f, y0 = %f, z0 = %f\n", x0, y0, z0);
% [x, ~, ~] = do_cordic(x0, y0, z0, PARAM_N_ITERATIONS, alphas, PARAM_DEBUG_CORDIC_OUTPUT);
% fprintf("True value: %.20f, Error: %.20f\n", cos(PARAM_TEST_ANGLE), abs(double(x)-cos(PARAM_TEST_ANGLE)));

foo = monte_carlo(1);

function results = monte_carlo(samples)
    % vary the number of iterations and the wordlength.
    iterations_ub = 35; % upper bound for number of cordic iterations
    iterations_lb = 35; % lower bound for number of cordic iterations
    wordlength_ub = 30; % upper bound for wordlength
    wordlength_lb = 30; % lower bound for wordlength

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
            display(K);

            % Perform monte carlo simulation for some N number of samples
            for i = 1:samples
                % set starting values
                x0 = fi(1/K, true, wordlength, wordlength-2);
                y0 = fi(0, true, wordlength, wordlength-2);
                z0 = fi(thetas(i), true, wordlength, wordlength-2);
                % call cordic but only keep the cos answer
                fprintf("Starting values: \tx0 = %f, y0 = %f, z0 = %f\n", x0, y0, z0);
                [x, ~, ~] = do_cordic(x0, y0, z0, iterations, alphas, 1);
                cordic_results(i) = x;
            end

            % post-processing
            % calculate error
            e = double(cordic_results) - true_values;
            display(e);
            % ME
            mean_e = sum(e) / samples;
            % lower and upper end points using z-value corresponding to 95% confidence interval
            lower_ep = mean_e - 1.96*std(e)/sqrt(samples);
            upper_ep = mean_e + 1.96*std(e)/sqrt(samples);
            interval = [lower_ep, upper_ep];
            display(interval);
            % store error interval wiht 95% confidence
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
            fprintf("After iteration %d: x = %.20f, y = %.20f, z = %.20f\n", iteration, x, y, z);
        end
    end
end

% xi, yi, zi - current values
% i - iteration number, starting from 0
function [x, y, z] = cordic_iteration(x, y, z, i, alphas)
    % first op - lookup
    alpha = fi(alphas(i), true, 101, 90); % note matlab uses 1-based indexing
    % di = cast(di, 'like', zi);
    x_s = bitsra(x, i-1);
    y_s = bitsra(y, i-1);
    % update x and y
    % fprintf("subtracting: %.20f\n", (sign(z))*alpha);
    x(:) = x - sign(z)*y_s;
    y(:) = y + sign(z)*x_s;
    z(:) = z - sign(z)*alpha;
    % cast to avoid error of "unable to fully represent number"
    % z = cast(z, 'like', zi);
    % display(z);
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

