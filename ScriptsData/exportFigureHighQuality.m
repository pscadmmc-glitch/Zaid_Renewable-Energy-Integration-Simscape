function exportFigureHighQuality(figHandle, baseFileName, varargin)
% exportFigureHighQuality - Export figure in multiple high-quality formats
%
% Syntax: exportFigureHighQuality(figHandle, baseFileName)
%         exportFigureHighQuality(figHandle, baseFileName, 'ParamName', ParamValue)
%
% Inputs:
%    figHandle    - Handle to the figure (use gcf for current figure)
%    baseFileName - Base name for the exported files (without extension)
%
% Optional Parameters:
%    'DPI'        - Resolution for PNG export (default: 900)
%    'Formats'    - Cell array of formats {'png', 'svg', 'fig'} (default: all three)
%    'Subfolder'  - Custom subfolder name (default: auto-generated with timestamp)
%    'BaseDir'    - Base directory for exports (default: 'ExportedFigures')
%
% Example:
%    fig = figure;
%    plot(x, y);
%    exportFigureHighQuality(fig, 'myplot');
%    exportFigureHighQuality(fig, 'scenario1', 'DPI', 1200);
%    exportFigureHighQuality(fig, 'test', 'Formats', {'png', 'svg'});
%
% This function exports figures to PNG (900 DPI default), SVG, and FIG formats
% in a subfolder with timestamp: scenario_DD_MM_YYYY_HHhMM

    % Parse input arguments
    p = inputParser;
    addRequired(p, 'figHandle');
    addRequired(p, 'baseFileName', @ischar);
    addParameter(p, 'DPI', 900, @isnumeric);
    addParameter(p, 'Formats', {'png', 'svg', 'fig'}, @iscell);
    addParameter(p, 'Subfolder', '', @ischar);
    addParameter(p, 'BaseDir', 'ExportedFigures', @ischar);

    parse(p, figHandle, baseFileName, varargin{:});

    dpi = p.Results.DPI;
    formats = p.Results.Formats;
    baseDir = p.Results.BaseDir;
    customSubfolder = p.Results.Subfolder;

    % Validate figure handle
    if ~ishandle(figHandle) || ~strcmp(get(figHandle, 'Type'), 'figure')
        error('exportFigureHighQuality:InvalidInput', 'First argument must be a valid figure handle');
    end

    try
        % Generate timestamp-based subfolder name if not provided
        if isempty(customSubfolder)
            timestamp = datetime('now');
            dateStr = sprintf('%02d_%02d_%d_%02dh%02d', ...
                day(timestamp), month(timestamp), year(timestamp), ...
                hour(timestamp), minute(timestamp));
            subfolderName = sprintf('%s_%s', baseFileName, dateStr);
        else
            subfolderName = customSubfolder;
        end

        % Get current script directory or use pwd
        try
            scriptPath = fileparts(mfilename('fullpath'));
            if isempty(scriptPath)
                scriptPath = pwd;
            end
        catch
            scriptPath = pwd;
        end

        % Create full export path
        exportPath = fullfile(scriptPath, baseDir, subfolderName);

        % Create directory if it doesn't exist
        if ~exist(exportPath, 'dir')
            mkdir(exportPath);
            fprintf('Created export directory: %s\n', exportPath);
        end

        % Prepare figure for export
        set(figHandle, 'Color', 'white');
        set(figHandle, 'PaperPositionMode', 'auto');
        set(figHandle, 'InvertHardcopy', 'off');

        % Export in requested formats
        for i = 1:length(formats)
            format = lower(formats{i});

            switch format
                case 'png'
                    % Export as PNG with specified DPI
                    pngFile = fullfile(exportPath, [baseFileName '.png']);
                    try
                        print(figHandle, pngFile, '-dpng', sprintf('-r%d', dpi));
                        fprintf('Exported PNG: %s (DPI: %d)\n', pngFile, dpi);
                    catch ME
                        warning('exportFigureHighQuality:PNGError', ...
                            'Failed to export PNG: %s', ME.message);
                    end

                case 'svg'
                    % Export as SVG (vector graphics)
                    svgFile = fullfile(exportPath, [baseFileName '.svg']);
                    try
                        print(figHandle, svgFile, '-dsvg');
                        fprintf('Exported SVG: %s\n', svgFile);
                    catch ME
                        warning('exportFigureHighQuality:SVGError', ...
                            'Failed to export SVG: %s', ME.message);
                    end

                case 'fig'
                    % Save as MATLAB figure
                    figFile = fullfile(exportPath, [baseFileName '.fig']);
                    try
                        savefig(figHandle, figFile);
                        fprintf('Exported FIG: %s\n', figFile);
                    catch ME
                        warning('exportFigureHighQuality:FIGError', ...
                            'Failed to export FIG: %s', ME.message);
                    end

                case 'eps'
                    % Export as EPS (optional, for publication quality)
                    epsFile = fullfile(exportPath, [baseFileName '.eps']);
                    try
                        print(figHandle, epsFile, '-depsc', '-tiff');
                        fprintf('Exported EPS: %s\n', epsFile);
                    catch ME
                        warning('exportFigureHighQuality:EPSError', ...
                            'Failed to export EPS: %s', ME.message);
                    end

                case 'pdf'
                    % Export as PDF (optional, for publication quality)
                    pdfFile = fullfile(exportPath, [baseFileName '.pdf']);
                    try
                        print(figHandle, pdfFile, '-dpdf', '-fillpage');
                        fprintf('Exported PDF: %s\n', pdfFile);
                    catch ME
                        warning('exportFigureHighQuality:PDFError', ...
                            'Failed to export PDF: %s', ME.message);
                    end

                otherwise
                    warning('exportFigureHighQuality:UnknownFormat', ...
                        'Unknown format: %s. Skipping...', format);
            end
        end

        fprintf('All exports completed successfully to: %s\n', exportPath);

    catch ME
        error('exportFigureHighQuality:ExportError', ...
            'Error during figure export: %s', ME.message);
    end
end
