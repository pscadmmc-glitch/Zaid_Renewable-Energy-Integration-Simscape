function BatteryStoragePVPlantGFMplotCurve_voltage_frequency(simlog,n,SimulationTime)
% BatteryStoragePVPlantGFMplotCurve_voltage_frequency - Plot voltage and frequency with LaTeX formatting
%
% Syntax: BatteryStoragePVPlantGFMplotCurve_voltage_frequency(simlog,n,SimulationTime)
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

    ax1=subplot(2,2,1);
v=simlog.get('Vmag_pcc').Values.Data(1:end);
aboveLine = (v>1.1 | v<0.9);
% Create 2 copies of v
bottomLine = v;
topLine = v;
% Set the values you don't want to get drawn to nan
bottomLine(aboveLine) = NaN;
topLine(~aboveLine) = NaN;
    grid on
    xlabel('Time (s)', 'Interpreter', 'latex');
    ylabel('Voltage (pu)', 'Interpreter', 'latex');
    xlim([0.6 SimulationTime])
    hold on;
    plot(simlog.get('Vmag_pcc').Values.Time(1:end),bottomLine,simlog.get('Vmag_pcc').Values.Time(1:end),topLine,'LineWidth',1.5);
    plot(simlog.get('Vmag_pcc').Values.Time(1:end),1.1*ones(size(simlog.get('Vmag_pcc').Values.Time(1:end))),'--g');
    plot(simlog.get('Vmag_pcc').Values.Time(1:end),0.9*ones(size(simlog.get('Vmag_pcc').Values.Time(1:end))),'--g');
    Vd=find(v(3e3:end)>1.1 | v(3e3:end)<0.9);
    if(length(Vd)>0)
         lgd=legend('$V_{\mathrm{mag}}$','$V_{\mathrm{out~of~limit}}$','$V_{\mathrm{limits}}$','Location','southeast', 'Interpreter', 'latex');
    else
        lgd=legend('$V_{\mathrm{mag}}$','','$V_{\mathrm{limits}}$','Location','southeast', 'Interpreter', 'latex');
    end
    lgd.NumColumns = 1;
    hold off;
    title('Voltage Magnitude at POI', 'Interpreter', 'latex');
    ax2=subplot(2,2,2);
    f=simlog.get('F_pcc').Values.Data(1:end);
    aboveLine = (f>61.2 | f<58.8);
    % Create 2 copies of f
    bottomLine = f;
    topLine = f;
    % Set the values you don't want to get drawn to nan
    bottomLine(aboveLine) = NaN;
    topLine(~aboveLine) = NaN;
    grid on
    xlabel('Time (s)', 'Interpreter', 'latex');
    ylabel('Frequency (Hz)', 'Interpreter', 'latex');
    xlim([0.6 3.5])
    hold on;
    plot(simlog.get('F_pcc').Values.Time(1:end),bottomLine,simlog.get('F_pcc').Values.Time(1:end),topLine,'LineWidth',1.5);
    plot(simlog.get('F_pcc').Values.Time(1:end),61.2*ones(size(simlog.get('F_pcc').Values.Time(1:end))),'--g');
    plot(simlog.get('F_pcc').Values.Time(1:end),58.8*ones(size(simlog.get('F_pcc').Values.Time(1:end))),'--g');
    fd=find(f(3e3:end)>1.1 | f(3e3:end)<0.9);
    if(length(Vd)>0)
        lgd=legend('$f$','$f_{\mathrm{out~of~limit}}$','$f_{\mathrm{limits}}$','Location','northeast', 'Interpreter', 'latex');
    else
        lgd=legend('$f$','','$f_{\mathrm{limits}}$','Location','northeast', 'Interpreter', 'latex');
    end
    lgd.NumColumns = 1;
    hold off;
    title('Frequency at POI', 'Interpreter', 'latex');
    xlim([0.6 SimulationTime])
    ax3=subplot(2,2,3);
    plot(simlog.get('Vabc_pcc').Values.Time(1:end), simlog.get('Vabc_pcc').Values.Data,'-', 'LineWidth', 1);
    grid on
    xlabel('Time (s)', 'Interpreter', 'latex');
    ylabel('Voltage (pu)', 'Interpreter', 'latex');
    xlim([0.6 SimulationTime])
    title('Voltages at POI', 'Interpreter', 'latex');
    legend('$V_a$', '$V_b$', '$V_c$', 'Interpreter', 'latex');

    ax4=subplot(2,2,4);
    plot(simlog.get('Iabc_bat').Values.Time(1:end), simlog.get('Iabc_bat').Values.Data,'-', 'LineWidth', 1);
    grid on
    xlabel('Time (s)', 'Interpreter', 'latex');
    ylabel('Current (pu)', 'Interpreter', 'latex');
    xlim([0.6 SimulationTime])
    title('BESS Inverter Currents', 'Interpreter', 'latex');
    legend('$I_a$', '$I_b$', '$I_c$', 'Interpreter', 'latex');

    linkaxes([ax1,ax2,ax3,ax4],'x');

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
    exportFigureHighQuality(fig, ['PVPlant_VoltageFrequency' scenarioName]);
end