function plotEigLBode(w,eigL,scan)
% plotEigLBode - Plot Bode diagram of eigenvalues of L(jω) with LaTeX formatting
%
% Syntax: plotEigLBode(w,eigL,scan)
%
% Inputs:
%    w    - Angular frequency vector
%    eigL - Eigenvalues of L
%    scan - Scan parameters structure

    % Add path to utility functions
    addpath(fileparts(mfilename('fullpath')));
    addpath(fullfile(fileparts(mfilename('fullpath')), '..', '..'));

    fig = figure('Name', 'Bode Plot of Eigenvalues of L(j\omega)', 'NumberTitle', 'off', 'Color', 'white');
    ax1 = subplot(2,1,1);
    semilogx(w/(2*pi), 20*log10(abs(eigL)),'LineWidth', 1);
    hold on;
    yline(0, '--r', '0 dB', 'LabelVerticalAlignment', 'top', 'Interpreter', 'latex');
    grid on;
    xlabel('Frequency (Hz)', 'Interpreter', 'latex');
    ylabel('Magnitude (dB)', 'Interpreter', 'latex');
    xlim([scan.f(1) scan.f(end)]);
    title('Magnitude of Eigenvalue of $L(j\omega)$', 'Interpreter', 'latex');
    legend(arrayfun(@(i) sprintf('$\\lambda_%d$', i), 1:2, 'UniformOutput', false), 'Location', 'best', 'Interpreter', 'latex');

    ax2 = subplot(2,1,2);
    semilogx(w/(2*pi), (angle(eigL))*(180/pi),'LineWidth', 1);
    hold on;
    yline(-180, '--r', '$-180^\circ$', 'LabelVerticalAlignment', 'top', 'Interpreter', 'latex');
    yline(180, '--r', '$180^\circ$', 'LabelVerticalAlignment', 'bottom', 'Interpreter', 'latex');
    grid on;
    xlabel('Frequency (Hz)', 'Interpreter', 'latex');
    ylabel('Phase (deg)', 'Interpreter', 'latex');
    xlim([scan.f(1) scan.f(end)]);
    title('Phase of Eigenvalue of $L(j\omega)$', 'Interpreter', 'latex');
    linkaxes([ax1, ax2], 'x');

    % Apply LaTeX formatting
    setupLatexPlot(fig);

    % Export figure
    exportFigureHighQuality(fig, 'EigenvalueLBode');
end