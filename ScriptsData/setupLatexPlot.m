function setupLatexPlot(figHandle)
% setupLatexPlot - Configure all text elements in figure to use LaTeX interpreter
%
% Syntax: setupLatexPlot(figHandle)
%
% Inputs:
%    figHandle - Handle to the figure (use gcf for current figure)
%
% Example:
%    fig = figure;
%    plot(x, y);
%    xlabel('Time $t$ [s]');
%    ylabel('Voltage $V$ [V]');
%    title('System Response');
%    setupLatexPlot(fig);
%
% This function sets LaTeX interpreter for all text objects in the figure
% including labels, titles, legends, and text annotations.

    if nargin < 1
        figHandle = gcf;
    end

    % Validate input
    if ~ishandle(figHandle) || ~strcmp(get(figHandle, 'Type'), 'figure')
        error('setupLatexPlot:InvalidInput', 'Input must be a valid figure handle');
    end

    try
        % Set default interpreter to LaTeX for this figure
        set(groot, 'defaultTextInterpreter', 'latex');
        set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
        set(groot, 'defaultLegendInterpreter', 'latex');
        set(groot, 'defaultColorbarTickLabelInterpreter', 'latex');

        % Find all axes in the figure
        allAxes = findall(figHandle, 'Type', 'axes');

        for i = 1:length(allAxes)
            ax = allAxes(i);

            % Set tick label interpreter
            set(ax, 'TickLabelInterpreter', 'latex');

            % Set xlabel
            if ~isempty(get(ax, 'XLabel'))
                set(get(ax, 'XLabel'), 'Interpreter', 'latex');
            end

            % Set ylabel
            if ~isempty(get(ax, 'YLabel'))
                set(get(ax, 'YLabel'), 'Interpreter', 'latex');
            end

            % Set zlabel if present
            if ~isempty(get(ax, 'ZLabel'))
                set(get(ax, 'ZLabel'), 'Interpreter', 'latex');
            end

            % Set title
            if ~isempty(get(ax, 'Title'))
                set(get(ax, 'Title'), 'Interpreter', 'latex');
            end

            % Set subtitle if present (MATLAB R2020b and later)
            try
                if ~isempty(get(ax, 'Subtitle'))
                    set(get(ax, 'Subtitle'), 'Interpreter', 'latex');
                end
            catch
                % Subtitle not supported in this MATLAB version
            end
        end

        % Find all legends in the figure
        allLegends = findall(figHandle, 'Type', 'legend');
        for i = 1:length(allLegends)
            set(allLegends(i), 'Interpreter', 'latex');
        end

        % Find all text objects in the figure
        allText = findall(figHandle, 'Type', 'text');
        for i = 1:length(allText)
            set(allText(i), 'Interpreter', 'latex');
        end

        % Find all colorbars in the figure
        allColorbars = findall(figHandle, 'Type', 'colorbar');
        for i = 1:length(allColorbars)
            set(allColorbars(i), 'TickLabelInterpreter', 'latex');
            if ~isempty(get(allColorbars(i), 'Label'))
                set(get(allColorbars(i), 'Label'), 'Interpreter', 'latex');
            end
        end

    catch ME
        warning('setupLatexPlot:Error', 'Error setting LaTeX interpreter: %s', ME.message);
    end
end
