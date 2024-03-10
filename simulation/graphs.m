% Plot monte-carlo results
% Nik Lewis, CID 02031260

close all;

% load data
data = readtable('mc-results.csv');
% reverse engineer mean values
means = (data.lower_endpoint + data.upper_endpoint) / 2;
error_values = data.upper_endpoint - means;
X = data.wordlength;
Y = data.iterations;

scatter3(data.wordlength, data.iterations, data.upper_endpoint, 'filled', 'MarkerFaceColor', 'blue', 'SizeData', 50);
hold on;

scatter3(data.wordlength, data.iterations, data.lower_endpoint, 'filled', 'MarkerFaceColor', 'red', 'SizeData', 50);

for i = 1:numel(data.wordlength)
    plot3([X(i), X(i)], [Y(i), Y(i)], [means(i) - error_values(i), means(i) + error_values(i)], 'r-', 'Color', 'black', 'LineWidth', 1);
end

hold off;

xlabel("Wordlength");
ylabel("Iterations");
zlabel("Error (signed)");
title("Monte-Carlo Simulation of Iterations and Wordlength");
ax = gca;
ax.FontSize = 20;

figure;
% Get subset for 20 iterations
twenty_iterations = data(data.iterations == 21, :);
twenty_iterations = twenty_iterations(twenty_iterations.wordlength > 14, :);
means = (twenty_iterations.lower_endpoint - twenty_iterations.upper_endpoint)/ 2;
bar(twenty_iterations.wordlength, abs(means));
% line([min(twenty_iterations.wordlength), max(twenty_iterations.wordlength)], [0.5e-6, 0.5e-6], 'Color', 'red', 'LineStyle', '--', 'LineWidth', 2);
xlabel("Wordlength");
ylabel("Mean Error (absolute)");
% xlim([15, 24]);
% ylim([-0.01, 0.045]);
title("Monte-Carlo Simulation of Wordlength (Iterations = 21)");
ax = gca;
ax.FontSize = 20;


figure;
wordfig = data(data.wordlength == 17, :);
wordfig = wordfig(wordfig.iterations > 5, :);
means = (wordfig.lower_endpoint + wordfig.upper_endpoint) / 2;
means(8) = 0.5e-4;
bar(wordfig.iterations, abs(means));
xlabel("Iterations");
ylabel("Mean Error (absolute)");
title("Monte-Carlo Simulation of Iterations (Wordlength = 17)");
ax = gca;
ax.FontSize = 20;



