function WindFarmGFMControlplotCurvevoltagefrequency(simlog,n,Tsim,control,code,tevent)
% WindFarmGFMControlplotCurvevoltagefrequency - Plot voltage and frequency with LaTeX formatting
%
% Syntax: WindFarmGFMControlplotCurvevoltagefrequency(simlog,n,Tsim,control,code,tevent)
%
% Inputs:
%    simlog  - Simulation log data structure
%    n       - Scenario number (1-6)
%    Tsim    - Total simulation time
%    control - Control type string
%    code    - Grid code parameters structure
%    tevent  - Event time
%
% Copyright 2023 The MathWorks, Inc.

    % Add path to utility functions
    addpath(fileparts(mfilename('fullpath')));
    addpath(fullfile(fileparts(mfilename('fullpath')), '..'));

    figure('Color', 'white');
bx1=subplot(2,2,1);
v=simlog.get('Vmag').Values.Data(100:end);
aboveLine = (v>code.vh | v<code.vl);
% Create 2 copies of v
bottomLine = v;
topLine = v;
% Set the values you don't want to get drawn to nan
bottomLine(aboveLine) = NaN;
topLine(~aboveLine) = NaN;
    grid on
    xlabel('Time (s)', 'Interpreter', 'latex');
    ylabel('Voltage (pu)', 'Interpreter', 'latex');
    xlim([tevent-1 tevent+1])
    hold on;
    plot(simlog.get('Vmag').Values.Time(100:end),bottomLine,simlog.get('Vmag').Values.Time(100:end),topLine,'LineWidth',1.5);
    plot(simlog.get('Vmag').Values.Time(100:end),1.1*ones(size(simlog.get('Vmag').Values.Time(100:end))),'--g');
    plot(simlog.get('Vmag').Values.Time(100:end),0.9*ones(size(simlog.get('Vmag').Values.Time(100:end))),'--g');
    Vd=find(v(1e3:end)>code.vh | v(1e3:end)<code.vl);
    if(length(Vd)>0)
         lgd=legend('$V_{\mathrm{mag}}$','$V_{\mathrm{out~of~limit}}$','$V_{\mathrm{limits}}$','Location','southeast', 'Interpreter', 'latex');
    else
        lgd=legend('$V_{\mathrm{mag}}$','','$V_{\mathrm{limits}}$','Location','southeast', 'Interpreter', 'latex');
    end
    lgd.NumColumns = 1;
    hold off;
    title('Voltage Magnitude at POI', 'Interpreter', 'latex');
    bx2=subplot(2,2,2);
    f=simlog.get('F').Values.Data(100:end);
    aboveLine = (f>code.fh | f<code.fl);
    % Create 2 copies of f
    bottomLine = f;
    topLine = f;
    % Set the values you don't want to get drawn to nan
    bottomLine(aboveLine) = NaN;
    topLine(~aboveLine) = NaN;
    grid on
    xlabel('Time (s)', 'Interpreter', 'latex');
    ylabel('Frequency (Hz)', 'Interpreter', 'latex');
    xlim([tevent-1 tevent+1])
    hold on;
    plot(simlog.get('F').Values.Time(100:end),bottomLine,simlog.get('F').Values.Time(100:end),topLine,'LineWidth',1.5);
    plot(simlog.get('F').Values.Time(100:end),61.2*ones(size(simlog.get('F').Values.Time(100:end))),'--g');
    plot(simlog.get('F').Values.Time(100:end),58.8*ones(size(simlog.get('F').Values.Time(100:end))),'--g');
    fd=find(f(1e3:end)>code.fh | f(1e3:end)<code.fl);
    if(length(Vd)>0)
        lgd=legend('$f$','$f_{\mathrm{out~of~limit}}$','$f_{\mathrm{limits}}$','Location','northeast', 'Interpreter', 'latex');
    else
        lgd=legend('$f$','','$f_{\mathrm{limits}}$','Location','southeast', 'Interpreter', 'latex');
    end
    lgd.NumColumns = 1;
    hold off;
    title('Frequency at POI', 'Interpreter', 'latex');
    xlim([tevent-1 tevent+1])
    bx3=subplot(2,2,3);
    plot(simlog.get('Vg').Values.Time(1:end), squeeze(simlog.get('Vg').Values.Data),'-', 'LineWidth', 1);
    grid on
    xlabel('Time (s)', 'Interpreter', 'latex');
    ylabel('Voltage (pu)', 'Interpreter', 'latex');
    xlim([tevent-.2 tevent+.2])
    title('Voltages at POI', 'Interpreter', 'latex');
    legend('$V_a$', '$V_b$', '$V_c$', 'Interpreter', 'latex');

    bx4=subplot(2,2,4);
    plot(simlog.get('Ig').Values.Time(1:end), squeeze(simlog.get('Ig').Values.Data),'-', 'LineWidth', 1);
    grid on
    xlabel('Time (s)', 'Interpreter', 'latex');
    ylabel('Current (pu)', 'Interpreter', 'latex');
    xlim([tevent-.2 tevent+.2])
    title('Currents Injected at POI', 'Interpreter', 'latex');
    legend('$I_a$', '$I_b$', '$I_c$', 'Interpreter', 'latex');

    linkaxes([bx1,bx2,bx3,bx4],'x');

    switch n
        case 3
          x=' Temporary Fault';
        case 5
          x=' Line Trip';
        case  2
          x=' Sudden Load Change';
        case 1
          x=' Sudden Change in Wind Power';
        case 4
          x=' Grid Outage';
        case 6
        x=' Steady Operation';
        otherwise
            x='';
    end
    sgtitle(strcat(x,control),'FontSize', 12, 'Interpreter', 'latex')

    % Get current figure handle
    fig = gcf;

    % Apply LaTeX formatting
    setupLatexPlot(fig);

    % Export figure with scenario name
    scenarioName = strrep(strtrim(x), ' ', '_');
    controlName = strrep(strtrim(control), ' ', '_');
    exportFigureHighQuality(fig, ['WindFarm_VoltageFrequency' scenarioName controlName]);
end