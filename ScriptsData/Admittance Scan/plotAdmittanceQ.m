function plotAdmittanceQ(sysQQ,sysQD,f)
% plotAdmittanceQ - Plot Q-axis admittances with LaTeX formatting
%
% Syntax: plotAdmittanceQ(sysQQ,sysQD,f)
%
% Inputs:
%    sysQQ - QQ axis admittance system
%    sysQD - QD axis admittance system
%    f     - Frequency vector

    % Add path to utility functions
    addpath(fileparts(mfilename('fullpath')));
    addpath(fullfile(fileparts(mfilename('fullpath')), '..'));

    % Bode plot
    fig1 = figure('Color', 'white');
    h1=bodeplot(sysQQ,sysQD,{f(1)*2*pi,f(end)*2*pi});
    setoptions(h1,'FreqUnits','Hz','grid','on','PhaseWrapping','off');
    legend('$Y_{QQ}$','$Y_{QD}$','Location','best', 'Interpreter', 'latex');
    title('$Q$ axis Admittances', 'Interpreter', 'latex');

    % Apply LaTeX formatting
    setupLatexPlot(fig1);

    % Export Bode plot
    exportFigureHighQuality(fig1, 'AdmittanceQ_Bode');

    % Nichols and pole-zero plots
    fig2 = figure('Color', 'white');
    subplot(2,2,1)
    nichols(sysQQ)
    ngrid
    title('$QQ$ axis Admittance Nichols Chart', 'Interpreter', 'latex');
    xlabel('Phase (deg)', 'Interpreter', 'latex');
    ylabel('Magnitude (dB)', 'Interpreter', 'latex');

    subplot(2,2,2)
    nichols(sysQD)
    title('$QD$ axis Admittance Nichols Chart', 'Interpreter', 'latex');
    xlabel('Phase (deg)', 'Interpreter', 'latex');
    ylabel('Magnitude (dB)', 'Interpreter', 'latex');
    ngrid

    subplot(2,2,3)
    pzplot(sysQQ)
    title('$QQ$ axis Poles and Zeros', 'Interpreter', 'latex');
    xlabel('Real Axis', 'Interpreter', 'latex');
    ylabel('Imaginary Axis', 'Interpreter', 'latex');

    subplot(2,2,4)
    pzplot(sysQD)
    title('$QD$ axis Poles and Zeros', 'Interpreter', 'latex');
    xlabel('Real Axis', 'Interpreter', 'latex');
    ylabel('Imaginary Axis', 'Interpreter', 'latex');

    % Apply LaTeX formatting
    setupLatexPlot(fig2);

    % Export Nichols and pole-zero plot
    exportFigureHighQuality(fig2, 'AdmittanceQ_Nichols_PoleZero');
end