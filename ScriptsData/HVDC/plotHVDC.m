function plotHVDC(Data,Tsim)
% plotHVDC - Plot HVDC system performance with LaTeX formatting
%
% Syntax: plotHVDC(Data,Tsim)
%
% Inputs:
%    Data - Simulation data structure
%    Tsim - Simulation time

    % Add path to utility functions
    addpath(fileparts(mfilename('fullpath')));
    addpath(fullfile(fileparts(mfilename('fullpath')), '..'));

    % Extract data
    PS1 = getsamples(Data.PST1,find(Data.tout==0.2):find(Data.tout==Tsim))/1e6;
    PS2 = getsamples(Data.PST2,find(Data.tout==0.2):find(Data.tout==Tsim))/1e6;
    PS3 = getsamples(Data.PST3,find(Data.tout==0.2):find(Data.tout==Tsim))/1e6;
    PS4 = getsamples(Data.PST4,find(Data.tout==0.2):find(Data.tout==Tsim))/1e6;
    PS5 = getsamples(Data.PST5,find(Data.tout==0.2):find(Data.tout==Tsim))/1e6;
    PS6 = getsamples(Data.PST6,find(Data.tout==0.2):find(Data.tout==Tsim))/1e6;
    V1 = getsamples(Data.Vabc,find(Data.tout==0.2):find(Data.tout==Tsim));
    I1 = getsamples(Data.Iabc,find(Data.tout==0.2):find(Data.tout==Tsim));
    V = getsamples(Data.Vmag,find(Data.tout==0.2):find(Data.tout==Tsim));
    F = getsamples(Data.f,find(Data.tout==0.2):find(Data.tout==Tsim));

    % Voltage limit detection
    aboveLinev = (V.Data>1.1 | V.Data<0.9);
    bottomLinev = V.Data;
    topLinev = V.Data;
    bottomLinev(aboveLinev) = NaN;
    topLinev(~aboveLinev) = NaN;

    % Frequency limit detection
    aboveLinef = (F.Data>61.2 | F.Data<58.8);
    bottomLinef = F.Data;
    topLinef = F.Data;
    bottomLinef(aboveLinef) = NaN;
    topLinef(~aboveLinef) = NaN;
    % Power and system performance plot
    c=figure('Color', 'white');
    subplot(2,2,1)
    plot(PS1)
    hold on;
    plot(PS2);
    plot(PS3);
    xlim([0.5 Tsim])
    ylim([0 500])
    ylabel('Power (MW)', 'Interpreter', 'latex');
    grid on;
    legend('$P_{\mathrm{Station~1}}$','$P_{\mathrm{Station~2}}$','$P_{\mathrm{Station~3}}$','Location','best', 'Interpreter', 'latex');
    title('Real Power From Onshore Stations', 'Interpreter', 'latex')

    subplot(2,2,2)
    plot(PS4)
    hold on;
    plot(PS5);
    plot(PS6);
    xlim([0.5 Tsim])
    ylabel('Power (MW)', 'Interpreter', 'latex');
    grid on;
    legend('$P_{\mathrm{Station~4}}$','$P_{\mathrm{Station~5}}$','$P_{\mathrm{Station~6}}$','Location','best', 'Interpreter', 'latex');
    title('Real Power From Offshore Stations', 'Interpreter', 'latex')

    subplot(2,2,3)
    plot(V.Time,bottomLinev,V.time,topLinev);
    hold on;
    plot(Data.tout,1.1*ones(size(Data.tout)),'--g');
    plot(Data.tout,0.9*ones(size(Data.tout)),'--g');
    xlim([0.5 Tsim]);
    xlabel('Time (s)', 'Interpreter', 'latex');
    ylabel('Voltage (pu)', 'Interpreter', 'latex');
    grid on;
    d=find(V.Data>1.1 | V.Data<0.9);
    if(length(d)>0)
         lgd=legend('$V_{\mathrm{mag}}$','$V_{\mathrm{out~of~limit}}$','$V_{\mathrm{limits}}$','Location','best', 'Interpreter', 'latex');
    else
        lgd=legend('$V_{\mathrm{mag}}$','','$V_{\mathrm{limits}}$','Location','best', 'Interpreter', 'latex');
    end
    title('Voltage Magnitude at Onshore Station 1', 'Interpreter', 'latex')

    subplot(2,2,4)
    plot(F.Time,bottomLinef,F.time,topLinef);
    hold on;
    plot(Data.tout,61.2*ones(size(Data.tout)),'--g');
    plot(Data.tout,58.8*ones(size(Data.tout)),'--g');
    xlim([0.5 Tsim]);
    xlabel('Time (s)', 'Interpreter', 'latex');
    ylabel('Frequency (Hz)', 'Interpreter', 'latex');
    grid on;
    df=find(F.Data>61.2 | F.Data<58.8);
    if(length(df)>0)
         lgd=legend('$f$','$f_{\mathrm{out~of~limit}}$','$f_{\mathrm{limits}}$','Location','best', 'Interpreter', 'latex');
    else
        lgd=legend('$f$','','$f_{\mathrm{limits}}$','Location','best', 'Interpreter', 'latex');
    end
    title('Onshore Frequency at POI', 'Interpreter', 'latex')
    set(c,'position',[0,0,700,400]);

    % Apply LaTeX formatting
    setupLatexPlot(c);

    % Export power and system performance plot
    exportFigureHighQuality(c, 'HVDC_PowerSystem');

    % ABC voltages and currents plot
    d=figure('Color', 'white');
    subplot(2,1,1)
    plot(V1);
    xlim([0.5 Tsim])
    ylim([-2 2])
    ylabel('Voltage (pu)', 'Interpreter', 'latex');
    xlabel('Time (s)', 'Interpreter', 'latex');
    grid on;
    title('Voltages at Onshore Station 1', 'Interpreter', 'latex')
    legend('$V_a$', '$V_b$', '$V_c$', 'Interpreter', 'latex', 'Location', 'best');

    subplot(2,1,2)
    plot(I1);
    xlim([0.5 Tsim])
    ylim([-2 2])
    ylabel('Current (pu)', 'Interpreter', 'latex');
    xlabel('Time (s)', 'Interpreter', 'latex');
    grid on;
    title('Currents at Onshore Station 1', 'Interpreter', 'latex')
    legend('$I_a$', '$I_b$', '$I_c$', 'Interpreter', 'latex', 'Location', 'best');

    % Apply LaTeX formatting
    setupLatexPlot(d);

    % Export ABC waveforms plot
    exportFigureHighQuality(d, 'HVDC_ABC_Waveforms');
end