function plotAdmittanceDCq(sysDCq,f)
% plotAdmittanceDCq - Plot DC transfer admittance on Q-axis disturbance with LaTeX formatting
%
% Syntax: plotAdmittanceDCq(sysDCq,f)
%
% Inputs:
%    sysDCq - DC transfer admittance on Q-axis disturbance system
%    f      - Frequency vector

    % Add path to utility functions
    addpath(fileparts(mfilename('fullpath')));
    addpath(fullfile(fileparts(mfilename('fullpath')), '..'));

    % Bode plot
    fig1 = figure('Color', 'white');
    h1=bodeplot(sysDCq,{f(1)*2*pi,f(end)*2*pi});
    setoptions(h1,'FreqUnits','Hz','grid','on','PhaseWrapping','off');
    legend('$Y_{qDC}$','Location','best', 'Interpreter', 'latex');
    title('DC Transfer Admittances on $Q$ axis Disturbance', 'Interpreter', 'latex');

    % Apply LaTeX formatting
    setupLatexPlot(fig1);

    % Export Bode plot
    exportFigureHighQuality(fig1, 'AdmittanceDCq_Bode');

    % Nichols and pole-zero plots
    fig2 = figure('Color', 'white');
    subplot(2,1,1)
    nichols(sysDCq)
    ngrid
    title('DC Transfer Admittance Nichols Chart ($Q$ axis)', 'Interpreter', 'latex');
    xlabel('Phase (deg)', 'Interpreter', 'latex');
    ylabel('Magnitude (dB)', 'Interpreter', 'latex');

    subplot(2,1,2)
    pzplot(sysDCq)
    title('DC Transfer Admittance Poles and Zeros ($Q$ axis)', 'Interpreter', 'latex');
    xlabel('Real Axis', 'Interpreter', 'latex');
    ylabel('Imaginary Axis', 'Interpreter', 'latex');

    % Apply LaTeX formatting
    setupLatexPlot(fig2);

    % Export Nichols and pole-zero plot
    exportFigureHighQuality(fig2, 'AdmittanceDCq_Nichols_PoleZero');
end