function plotAdmittanceDQdc(sysDC,sysQDC,f)
% plotAdmittanceDQdc - Plot D and Q axis transfer admittances on DC bus disturbance with LaTeX formatting
%
% Syntax: plotAdmittanceDQdc(sysDC,sysQDC,f)
%
% Inputs:
%    sysDC  - D to DC transfer admittance system
%    sysQDC - Q to DC transfer admittance system
%    f      - Frequency vector

    % Add path to utility functions
    addpath(fileparts(mfilename('fullpath')));
    addpath(fullfile(fileparts(mfilename('fullpath')), '..'));

    % Bode plot
    fig1 = figure('Color', 'white');
    h1=bodeplot(sysDC,sysQDC,{f(1)*2*pi,f(end)*2*pi});
    setoptions(h1,'FreqUnits','Hz','grid','on','PhaseWrapping','off');
    legend('$Y_{Ddc}$','$Y_{Qdc}$','Location','best', 'Interpreter', 'latex');
    title('$D$ and $Q$ axis Transfer Admittances on DC bus disturbance', 'Interpreter', 'latex');

    % Apply LaTeX formatting
    setupLatexPlot(fig1);

    % Export Bode plot
    exportFigureHighQuality(fig1, 'AdmittanceDQdc_Bode');

    % Nichols and pole-zero plots
    fig2 = figure('Color', 'white');
    subplot(2,2,1)
    nichols(sysDC)
    ngrid
    title('$D$ to DC Transfer Admittance Nichols Chart', 'Interpreter', 'latex');
    xlabel('Phase (deg)', 'Interpreter', 'latex');
    ylabel('Magnitude (dB)', 'Interpreter', 'latex');

    subplot(2,2,2)
    nichols(sysQDC)
    title('$Q$ to DC Admittance Nichols Chart', 'Interpreter', 'latex');
    xlabel('Phase (deg)', 'Interpreter', 'latex');
    ylabel('Magnitude (dB)', 'Interpreter', 'latex');
    ngrid

    subplot(2,2,3)
    pzplot(sysDC)
    title('$D$ to DC axis Poles and Zeros', 'Interpreter', 'latex');
    xlabel('Real Axis', 'Interpreter', 'latex');
    ylabel('Imaginary Axis', 'Interpreter', 'latex');

    subplot(2,2,4)
    pzplot(sysQDC)
    title('$Q$ to DC axis Poles and Zeros', 'Interpreter', 'latex');
    xlabel('Real Axis', 'Interpreter', 'latex');
    ylabel('Imaginary Axis', 'Interpreter', 'latex');

    % Apply LaTeX formatting
    setupLatexPlot(fig2);

    % Export Nichols and pole-zero plot
    exportFigureHighQuality(fig2, 'AdmittanceDQdc_Nichols_PoleZero');
end