% Simulation of CORDIC
% Nik Lewis, CID 02031260

close all;
format long;

% Parameters to be tweaked to fit specification
PARAM_WORD_LENGTH = 24; % 24 bit total wordlength extracted from FP->fixed conversion
PARAM_FRACTION_LENGTH = 23; % 23 of these are fractional bits by default
PARAM_N_ITERATIONS = 20; % number of cordic iterations
PARAM_TEST_ANGLE = 0.5; % test angle z0 in radians
PARAM_DEBUG_CORDIC_OUTPUT = 0;
PARAM_FIXED_POINT = 1;

% Takes input as fixed-point number
iterations = 0:1:PARAM_N_ITERATIONS-1;
alphas = calculate_alpha(iterations);

% inits
K = prod(sqrt(1 + 2.^(-2*(iterations))));
if (PARAM_FIXED_POINT == 1); x0 = fi(1/K, true, PARAM_WORD_LENGTH, PARAM_FRACTION_LENGTH); else; x0 = 1/K; end
if (PARAM_FIXED_POINT == 1); y0 = fi(0, true, PARAM_WORD_LENGTH, PARAM_FRACTION_LENGTH); else; y0 = 0; end
if (PARAM_FIXED_POINT == 1); z0 = fi(PARAM_TEST_ANGLE, true, PARAM_WORD_LENGTH, PARAM_FRACTION_LENGTH); else; z0 = PARAM_TEST_ANGLE; end

fprintf("Starting values: \tx0 = %f, y0 = %f, z0 = %f\n", x0, y0, z0);
[x, y, z] = do_cordic(x0, y0, z0, PARAM_N_ITERATIONS, alphas, PARAM_DEBUG_CORDIC_OUTPUT, PARAM_WORD_LENGTH, PARAM_FRACTION_LENGTH);
fprintf("Cordic values: \t\tx = %.20f, y = %.20f, z = %.20f\n", x, y, z);
fprintf("Double precision: \tcos = %.20f, sin = %.20f\n", cos(PARAM_TEST_ANGLE), sin(PARAM_TEST_ANGLE));

function [x, y, z] = do_cordic(x0, y0, z0, N, alphas, PARAM_DEBUG_CORDIC_OUTPUT, PARAM_WORD_LENGTH, PARAM_FRACTION_LENGTH)
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
function [x, y, z] = cordic_iteration(xi, yi, zi, i, alphas)
    % first op - lookup
    alpha = alphas(i); % note matlab uses 1-based indexing
    % get sign of current angle
    di = sign(zi);
    % di = cast(di, 'like', zi);
    z = zi - di*alpha;

    % update x and y
    x = xi - di*yi*2^-(i-1);
    y = yi + di*xi*2^-(i-1);

    % cast to avoid error of "unable to fully represent number"
    z = cast(z, 'like', zi);
    x = cast(x, 'like', xi);
    y = cast(y, 'like', yi);
end

function alpha = calculate_alpha(i)
    alpha = fi(atan(2.^-i), true, 30, 20);
    % alpha = atand(2.^-i);
end

