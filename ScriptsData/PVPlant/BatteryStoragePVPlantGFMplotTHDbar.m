%% BatteryStoragePVPlantGFMplotTHDbar - Plot THD bar chart with LaTeX formatting
%
% This file plots the THD for the simulation
% Copyright 2022 - 2023 The MathWorks, Inc.

% Add path to utility functions
addpath(fileparts(mfilename('fullpath')));
addpath(fullfile(fileparts(mfilename('fullpath')), '..'));

fig = figure('Color', 'white');
tsI.data=simlog2.get('ITHD').Values.Data;
tsI.time=simlog2.get('ITHD').Values.Time;
tsV.data=simlog2.get('VTHD').Values.Data;
tsV.time=simlog2.get('VTHD').Values.Time;
maxITHD=max(tsI.data(10e3:end)); % start THD calculation from 1 sec
maxVTHD=max(tsV.data(10e3:end)); % start THD calculation from 1 sec
hb=bar([5,maxITHD;8,maxVTHD]);
xticks={'Current THD','Voltage THD'};
DesignTest={'IEEE Recommended Maximum THD','Maximum THD for Simulated Model'};
ylabel('\% THD', 'Interpreter', 'latex');
xticklabels(xticks);
hLg=legend(DesignTest,'Location','northwest', 'Interpreter', 'latex');
title('Total Harmonic Distortion Comparison', 'Interpreter', 'latex');
grid on;

% Apply LaTeX formatting
setupLatexPlot(fig);

% Export figure
exportFigureHighQuality(fig, 'PVPlant_THD_Comparison');

%%
% Copyright 2022 The MathWorks Inc