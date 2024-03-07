% Simulation of CORDIC
% Nik Lewis, CID 02031260

close all;
format long;

% Parameters to be tweaked to fit specification
PARAM_WORD_LENGTH = 24; % 24 bit total wordlength extracted from FP->fixed conversion
PARAM_FRACTION_LENGTH = 23; % 23 of these are fractional bits by default
PARAM_N_ITERATIONS = 20;

% Takes input as fixed-point number
iterations = 0:1:PARAM_N_ITERATIONS-1;
alphas = fi(calculate_alpha(iterations), true, PARAM_WORD_LENGTH, PARAM_FRACTION_LENGTH);

% inits
K = prod(sqrt(1 + 2.^(-2*(iterations))));
x0 = fi(1/K, true, PARAM_WORD_LENGTH, PARAM_FRACTION_LENGTH);
y0 = fi(0.0, true, PARAM_WORD_LENGTH, PARAM_FRACTION_LENGTH);
z0 = fi(0.5, true, PARAM_WORD_LENGTH, PARAM_FRACTION_LENGTH);

fprintf("Starting values: x0 = %f, y0 = %f, z0 = %f\n", x0, y0, z0);
display(alphas);
do_cordic(x0, y0, z0, PARAM_N_ITERATIONS, alphas);

function [x, y, z] = do_cordic(x0, y0, z0, N, alphas)
    % init
    x = x0;
    y = y0;
    z = z0;
    for iteration = 1:1:N
        [x, y, z] = cordic_iteration(x, y, z, iteration, alphas);
        fprintf("After iteration %d: x = %.20f, y = %.20f, z = %.20f\n", iteration, x, y, z);
    end
end

% xi, yi, zi - current values
% i - iteration number, starting from 0
function [x, y, z] = cordic_iteration(xi, yi, zi, i, alphas)
    % first op - lookup
    alpha = alphas(i); % note matlab uses 1-based indexing
    % display(alpha);
    % get sign of current angle
    di = sign(zi);

    z = zi - di*alpha;
    fprintf("subtracting alpha = %d*%f\n", di, alpha);
    % z = cast(z, 'like', zi);

    % update x and y
    x = xi - di*yi*2^-(i-1);
    y = yi + di*xi*2^-(i-1);
    x = cast(x, 'like', xi);
    y = cast(y, 'like', yi);
end

function alpha = calculate_alpha(i)
    alpha = atand(2.^-i);
end

