function BatteryStoragePVPlantGFMplotCurve_power(simlog,n,SimulationTime)
% BatteryStoragePVPlantGFMplotCurve_power - Plot real and reactive powers with LaTeX formatting
%
% Syntax: BatteryStoragePVPlantGFMplotCurve_power(simlog,n,SimulationTime)
%
% Inputs:
%    simlog         - Simulation log data structure
%    n              - Scenario number (1-6)
%    SimulationTime - Total simulation time
%
% Copyright 2022 - 2023 The MathWorks, Inc.

    % Add path to utility functions
    addpath(fileparts(mfilename('fullpath')));
    addpath(fullfile(fileparts(mfilename('fullpath')), '..'));

    % Plot results
    bx1=subplot(2,1,1);
    plot(simlog.get('P_total').Values.Time(1:end), 10^-6*simlog.get('P_total').Values.Data(1:end),'-', 'LineWidth', 1.5,'Color','#0072BD')
    hold on;
    plot(simlog.get('P_bat').Values.Time(1:end), 10^-6*simlog.get('P_bat').Values.Data(1:end),'-', 'LineWidth', 1.5,'Color','#D95319')
    plot(simlog.get('P_PV_park').Values.Time(1:end), 10^-6*simlog.get('P_PV_park').Values.Data(1:end),'-', 'LineWidth', 1.5,'Color','#EDB120')
    grid on
    xlabel('Time (s)', 'Interpreter', 'latex')
    ylabel('Power (MW)', 'Interpreter', 'latex')
    legend('$P_{\mathrm{Total}}$','$P_{\mathrm{Battery}}$', '$P_{\mathrm{PV~Plant}}$', 'Interpreter', 'latex')
    xlim([0.6 SimulationTime])
    title('Real Power Output', 'Interpreter', 'latex')

    bx2=subplot(2,1,2);
    plot(simlog.get('Q_total').Values.Time(1:end), 10^-6*simlog.get('Q_total').Values.Data(1:end),'-', 'LineWidth', 1.5,'Color','#0072BD');
    hold on;
    plot(simlog.get('Q_bat').Values.Time(1:end), 10^-6*simlog.get('Q_bat').Values.Data(1:end),'-', 'LineWidth', 1.5,'Color','#D95319');
    plot(simlog.get('Q_PV_park').Values.Time(1:end), 10^-6*simlog.get('Q_PV_park').Values.Data(1:end),'-', 'LineWidth', 1.5,'Color','#EDB120')
    grid on
    xlabel('Time (s)', 'Interpreter', 'latex')
    ylabel('Reactive Power (MVAR)', 'Interpreter', 'latex')
    legend('$Q_{\mathrm{Total}}$','$Q_{\mathrm{Battery}}$', '$Q_{\mathrm{PV~Plant}}$', 'Interpreter', 'latex')
    xlim([0.6 SimulationTime])
    title('Reactive Power Output', 'Interpreter', 'latex')
    linkaxes([bx1,bx2],'x');

    switch n
        case 4
          x=' Temporary Fault';
        case 5
          x=' Permanent Fault';
        case  2
          x=' Sudden Load Change';
        case 1
          x=' Sudden Change in PV power';
        case 3
          x=' Grid Outage';
        case 6
        x=' Steady Operation';
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
    exportFigureHighQuality(fig, ['PVPlant_Power' scenarioName]);
end