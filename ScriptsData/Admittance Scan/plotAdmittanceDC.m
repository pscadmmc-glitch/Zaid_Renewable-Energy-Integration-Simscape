function plotAdmittanceDC(sysDC,f)
% plotAdmittanceDC - Plot DC admittance with LaTeX formatting
%
% Syntax: plotAdmittanceDC(sysDC,f)
%
% Inputs:
%    sysDC - DC admittance system
%    f     - Frequency vector

    % Add path to utility functions
    addpath(fileparts(mfilename('fullpath')));
    addpath(fullfile(fileparts(mfilename('fullpath')), '..'));

    % Bode plot
    fig1 = figure('Color', 'white');
    h1=bodeplot(sysDC,{f(1)*2*pi,f(end)*2*pi});
    setoptions(h1,'FreqUnits','Hz','grid','on','PhaseWrapping','off');
    legend('$Y_{DC}$','Location','best', 'Interpreter', 'latex');
    title('DC Admittances', 'Interpreter', 'latex');

    % Apply LaTeX formatting
    setupLatexPlot(fig1);

    % Export Bode plot
    exportFigureHighQuality(fig1, 'AdmittanceDC_Bode');

    % Nichols and pole-zero plots
    fig2 = figure('Color', 'white');
    subplot(2,1,1)
    nichols(sysDC)
    ngrid
    title('DC Admittance Nichols Chart', 'Interpreter', 'latex');
    xlabel('Phase (deg)', 'Interpreter', 'latex');
    ylabel('Magnitude (dB)', 'Interpreter', 'latex');

    subplot(2,1,2)
    pzplot(sysDC)
    title('DC Admittance Poles and Zeros', 'Interpreter', 'latex');
    xlabel('Real Axis', 'Interpreter', 'latex');
    ylabel('Imaginary Axis', 'Interpreter', 'latex');

    % Apply LaTeX formatting
    setupLatexPlot(fig2);

    % Export Nichols and pole-zero plot
    exportFigureHighQuality(fig2, 'AdmittanceDC_Nichols_PoleZero');
end