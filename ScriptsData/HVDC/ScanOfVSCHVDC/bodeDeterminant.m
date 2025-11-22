function bodeDeterminant(eigL, w,scan)
% bodeDeterminant - Compute and plot the scalar determinant of (I + L(jω)) with LaTeX formatting
%
% Syntax: bodeDeterminant(eigL, w, scan)
%
% Inputs:
%    eigL - Eigenvalues of L
%    w    - Angular frequency vector
%    scan - Scan parameters structure

    % Add path to utility functions
    addpath(fileparts(mfilename('fullpath')));
    addpath(fullfile(fileparts(mfilename('fullpath')), '..', '..'));

    % Eigenvalue product method
    detL = prod(1 + eigL, 1);  % Row vector (1 x N)
    f = w / (2*pi); % Frequency vector in Hz

    % Magnitude and phase
    magdB = abs(detL);
    phase_deg = angle(detL) * (180/pi);

    % Plot
    fig = figure('Color', 'white');
    subplot(2,1,1);
    semilogx(f, magdB, 'b', 'LineWidth', 1.5);
    grid on;
    ylabel('$|det(I+L)|$', 'Interpreter', 'latex');
    title('Bode Plot of $\det(I + L(j\omega))$', 'Interpreter', 'latex');
    xlim([scan.f(1) scan.f(end)]);

    subplot(2,1,2);
    semilogx(f, phase_deg, 'r', 'LineWidth', 1.5);
    grid on;
    xlabel('Frequency (Hz)', 'Interpreter', 'latex');
    ylabel('Phase (deg)', 'Interpreter', 'latex');
    xlim([scan.f(1) scan.f(end)]);

    % Apply LaTeX formatting
    setupLatexPlot(fig);

    % Export figure
    exportFigureHighQuality(fig, 'BodeDeterminant');
end