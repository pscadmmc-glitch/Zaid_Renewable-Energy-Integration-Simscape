function WindFarmGFMControlplotCurvepower(simlog,n,Tsim)
% WindFarmGFMControlplotCurvepower - Plot real and reactive powers with LaTeX formatting
%
% Syntax: WindFarmGFMControlplotCurvepower(simlog,n,Tsim)
%
% Inputs:
%    simlog - Simulation log data structure
%    n      - Scenario number (1-6)
%    Tsim   - Total simulation time
%
% Copyright 2023 The MathWorks, Inc.

    % Add path to utility functions
    addpath(fileparts(mfilename('fullpath')));
    addpath(fullfile(fileparts(mfilename('fullpath')), '..'));

    % Plot results
    ax1=subplot(2,1,1);
    plot(simlog.get('PTotal').Values.Time(1:end), 10^-6*squeeze(simlog.get('PTotal').Values.Data(1:end)),'-', 'LineWidth', 1.5,'Color','#0072BD')
    hold on;
    plot(simlog.get('P_GFM').Values.Time(1:end), 10^-6*squeeze(simlog.get('QTotal').Values.Data(1:end)),'-', 'LineWidth', 1.5,'Color','#D95319')
    grid on
    xlabel('Time (s)', 'Interpreter', 'latex')
    ylabel('Power (MW)', 'Interpreter', 'latex')
    legend('$P_{\mathrm{Total}}$','$Q_{\mathrm{Total}}$', 'Interpreter', 'latex')
    xlim([0.6 Tsim])
    title('Total Power Output', 'Interpreter', 'latex')

    ax2=subplot(2,1,2);
    plot(simlog.get('QTotal').Values.Time(1:end), 10^-6*squeeze(simlog.get('P_GFM').Values.Data(1:end)),'-', 'LineWidth', 1.5,'Color','#0072BD');
    hold on;
    plot(simlog.get('Q_GFM').Values.Time(1:end), 10^-6*squeeze(simlog.get('Q_GFM').Values.Data(1:end)),'-', 'LineWidth', 1.5,'Color','#D95319');
    grid on
    xlabel('Time (s)', 'Interpreter', 'latex')
    ylabel('Reactive Power (MVAR)', 'Interpreter', 'latex')
    legend('$P_{\mathrm{GFM~Wind}}$','$Q_{\mathrm{GFM~Wind}}$', 'Interpreter', 'latex')
    xlim([0.6 Tsim])
    title('GFM Power Output', 'Interpreter', 'latex')
    linkaxes([ax1,ax2],'x');

    switch n
        case 3
          x='Temporary Fault';
        case 5
          x='Tripping of Wind Generator';
        case  2
          x='Sudden Load Change';
        case 1
          x='Sudden Change in Wind Power';
        case 4
          x='Grid Outage';
        case 6
        x='Steady Operation';
        otherwise
            x='';
    end
    sgtitle(x, 'Interpreter', 'latex')

    % Get current figure handle
    fig = gcf;
    set(fig, 'Color', 'white');

    % Apply LaTeX formatting
    setupLatexPlot(fig);

    % Export figure with scenario name
    scenarioName = strrep(strtrim(x), ' ', '_');
    exportFigureHighQuality(fig, ['WindFarm_Power' scenarioName]);
end