% plotPowerCurves - Plot wind turbine power curves with LaTeX formatting
%
% This script plots wind turbine power curves across different wind speeds

% Add path to utility functions
addpath(fileparts(mfilename('fullpath')));
addpath(fullfile(fileparts(mfilename('fullpath')), '..'));

fig = figure('Color', 'white');
plot(turbineRPMv,power2/1e6)
plot(turbineRPMv,power2/1e6),grid on;
xlabel('Turbine RPM', 'Interpreter', 'latex')
ylabel('Power (MW)', 'Interpreter', 'latex')
title('Wind Turbine Power Curves', 'Interpreter', 'latex')

[maxPower,maxPowerRPM] = max(power2'/1e6);

hold on
plot(maxPowerRPM,maxPower,'r','LineWidth',2,'Marker','+')
labels=num2str([5:11].','wind: %d m/s');
lgd = legend(labels,'Location','best');
set(lgd, 'Interpreter', 'latex');

% Apply LaTeX formatting
setupLatexPlot(fig);

% Export figure
exportFigureHighQuality(fig, 'WindTurbine_PowerCurves');