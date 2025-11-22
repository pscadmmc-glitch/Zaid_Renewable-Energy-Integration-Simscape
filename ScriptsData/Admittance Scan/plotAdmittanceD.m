function plotAdmittanceD(sysDD,sysDQ,f)
% plotAdmittanceD - Plot D-axis admittances with LaTeX formatting
%
% Syntax: plotAdmittanceD(sysDD,sysDQ,f)
%
% Inputs:
%    sysDD - DD axis admittance system
%    sysDQ - DQ axis admittance system
%    f     - Frequency vector

    % Add path to utility functions
    addpath(fileparts(mfilename('fullpath')));
    addpath(fullfile(fileparts(mfilename('fullpath')), '..'));

    % Bode plot
    fig1 = figure('Color', 'white');
    h1=bodeplot(sysDD,sysDQ,{f(1)*2*pi,f(end)*2*pi});
    setoptions(h1,'FreqUnits','Hz','grid','on','PhaseWrapping','off');
    legend('$Y_{DD}$','$Y_{DQ}$','Location','best', 'Interpreter', 'latex');
    title('$D$ axis Admittances', 'Interpreter', 'latex');

    % Apply LaTeX formatting
    setupLatexPlot(fig1);

    % Export Bode plot
    exportFigureHighQuality(fig1, 'AdmittanceD_Bode');

    % Nichols and pole-zero plots
    fig2 = figure('Color', 'white');
    subplot(2,2,1)
    nichols(sysDD)
    ngrid
    title('$DD$ axis Admittance Nichols Chart', 'Interpreter', 'latex');
    xlabel('Phase (deg)', 'Interpreter', 'latex');
    ylabel('Magnitude (dB)', 'Interpreter', 'latex');

    subplot(2,2,2)
    nichols(sysDQ)
    title('$DQ$ axis Admittance Nichols Chart', 'Interpreter', 'latex');
    xlabel('Phase (deg)', 'Interpreter', 'latex');
    ylabel('Magnitude (dB)', 'Interpreter', 'latex');
    ngrid

    subplot(2,2,3)
    pzplot(sysDD)
    title('$DD$ axis Poles and Zeros', 'Interpreter', 'latex');
    xlabel('Real Axis', 'Interpreter', 'latex');
    ylabel('Imaginary Axis', 'Interpreter', 'latex');

    subplot(2,2,4)
    pzplot(sysDQ)
    title('$DQ$ axis Poles and Zeros', 'Interpreter', 'latex');
    xlabel('Real Axis', 'Interpreter', 'latex');
    ylabel('Imaginary Axis', 'Interpreter', 'latex');

    % Apply LaTeX formatting
    setupLatexPlot(fig2);

    % Export Nichols and pole-zero plot
    exportFigureHighQuality(fig2, 'AdmittanceD_Nichols_PoleZero');
end