# Plotting Enhancements - LaTeX Formatting and High-Quality Export

## Overview

All plotting files in this repository have been enhanced with:
- **LaTeX formatting** for all text elements (labels, titles, legends, subtitles)
- **Automatic high-quality export** to multiple formats (PNG at 900 DPI, SVG, FIG)
- **Timestamped export folders** for organized figure management
- **Robust error handling** and backward compatibility

## Date of Enhancement
November 22, 2025

## Enhanced Files

### Utility Functions (2 files)
Located in `ScriptsData/`:
1. **setupLatexPlot.m** - Configures LaTeX interpreter for all figure text elements
2. **exportFigureHighQuality.m** - Exports figures in multiple high-quality formats

### Admittance Scan Plots (6 files)
Located in `ScriptsData/Admittance Scan/`:
1. `plotAdmittanceD.m` - D-axis admittances (Bode, Nichols, Pole-Zero)
2. `plotAdmittanceQ.m` - Q-axis admittances (Bode, Nichols, Pole-Zero)
3. `plotAdmittanceDC.m` - DC admittance analysis
4. `plotAdmittanceDCd.m` - DC transfer admittance on D-axis disturbance
5. `plotAdmittanceDCq.m` - DC transfer admittance on Q-axis disturbance
6. `plotAdmittanceDQdc.m` - D and Q axis transfer admittances on DC bus disturbance

### HVDC Plots (6 files)
Located in `ScriptsData/HVDC/` and `ScriptsData/HVDC/ScanOfVSCHVDC/`:
1. `plotHVDC.m` - HVDC system performance (power, voltage, frequency, ABC waveforms)
2. `plotPowerCurves.m` - Wind turbine power curves
3. `bodeDeterminant.m` - Bode plot of determinant of (I + L(jω))
4. `plotEigLBode.m` - Bode diagram of eigenvalues of L(jω)
5. `generalizedNyquistPlotwithCrossing.m` - Generalized Nyquist plot with stability markers
6. `encirclementNyquistPlot.m` - Eigenvalue encirclement analysis (computation only)

### PV Plant Plots (3 primary files)
Located in `ScriptsData/PVPlant/`:
1. `BatteryStoragePVPlantGFMplotCurve_power.m` - Real and reactive power plots
2. `BatteryStoragePVPlantGFMplotCurve_voltage_frequency.m` - Voltage and frequency analysis
3. `BatteryStoragePVPlantGFMplotTHDbar.m` - Total Harmonic Distortion bar chart

### Wind Model Plots (2 primary files)
Located in `ScriptsData/Wind Model/`:
1. `WindFarmGFMControlplotCurvepower.m` - Wind farm power output
2. `WindFarmGFMControlplotCurvevoltagefrequency.m` - Wind farm voltage and frequency

## Features

### LaTeX Formatting
All plots now use LaTeX interpreter for:
- **X-axis labels**: Time (s), Frequency (Hz), etc.
- **Y-axis labels**: Power (MW), Voltage (pu), Current (pu), Magnitude (dB), Phase (deg)
- **Titles**: All plot titles with proper mathematical notation
- **Legends**: Subscripts and special characters rendered in LaTeX
- **Subtitles**: Scenario descriptions and figure annotations

Example LaTeX formatting:
- `$P_{\mathrm{Total}}$` for total power
- `$V_{\mathrm{mag}}$` for voltage magnitude
- `$Y_{DD}$` for DD-axis admittance
- `$L(j\omega)$` for transfer function

### High-Quality Export

Each plot is automatically exported to a timestamped subfolder in three formats:

#### Export Formats
1. **PNG** - Raster image at 900 DPI (customizable)
2. **SVG** - Vector graphics for publication quality
3. **FIG** - MATLAB figure file for future editing

#### Folder Structure
```
ScriptsData/
├── Admittance Scan/
│   └── ExportedFigures/
│       └── AdmittanceD_Bode_22_11_2025_14h30/
│           ├── AdmittanceD_Bode.png
│           ├── AdmittanceD_Bode.svg
│           └── AdmittanceD_Bode.fig
├── HVDC/
│   └── ExportedFigures/
│       └── HVDC_PowerSystem_22_11_2025_14h35/
│           ├── HVDC_PowerSystem.png
│           ├── HVDC_PowerSystem.svg
│           └── HVDC_PowerSystem.fig
└── ...
```

## Usage

### Basic Usage
All plotting functions work exactly as before. The enhancements are automatic:

```matlab
% Example: Plot D-axis admittance
plotAdmittanceD(sysDD, sysDQ, f);
% Automatically creates plots with LaTeX formatting and exports them
```

### Custom Export Settings

You can customize export behavior using the utility functions directly:

```matlab
% Create your plot
fig = figure;
plot(x, y);
xlabel('Time (s)');
ylabel('Voltage (V)');
title('System Response');

% Apply LaTeX formatting
setupLatexPlot(fig);

% Export with custom settings
exportFigureHighQuality(fig, 'myplot', 'DPI', 1200, 'Formats', {'png', 'pdf'});
```

### Export Function Parameters

#### exportFigureHighQuality Options
- **DPI**: Resolution for PNG (default: 900)
- **Formats**: Cell array of formats (default: {'png', 'svg', 'fig'})
  - Available: 'png', 'svg', 'fig', 'eps', 'pdf'
- **Subfolder**: Custom subfolder name (default: auto-generated with timestamp)
- **BaseDir**: Base directory for exports (default: 'ExportedFigures')

Example:
```matlab
exportFigureHighQuality(fig, 'scenario1', ...
    'DPI', 1200, ...
    'Formats', {'png', 'svg', 'pdf'}, ...
    'Subfolder', 'scenario12_11_2025_14h30');
```

## Robustness Features

### Error Handling
- All utility functions include try-catch blocks
- Warning messages for non-critical errors
- Graceful degradation if LaTeX interpreter fails

### Backward Compatibility
- Original function signatures unchanged
- Works with existing scripts without modification
- Path handling works across different MATLAB versions

### File Safety
- Creates directories only when needed
- Unique timestamp-based folder names prevent overwrites
- Multiple export format attempts are independent

## Testing Recommendations

To verify the enhancements work correctly:

1. **Test Admittance Plots**:
   ```matlab
   cd('ScriptsData/Admittance Scan')
   % Run your admittance scan analysis
   % Check ExportedFigures/ for output
   ```

2. **Test HVDC Plots**:
   ```matlab
   cd('ScriptsData/HVDC')
   % Run HVDC simulation
   % Verify LaTeX rendering in figures
   ```

3. **Test PV Plant Plots**:
   ```matlab
   cd('ScriptsData/PVPlant')
   % Run battery storage simulation
   % Check figure quality and exports
   ```

4. **Test Wind Model Plots**:
   ```matlab
   cd('ScriptsData/Wind Model')
   % Run wind farm simulation
   % Verify all scenarios export correctly
   ```

## Troubleshooting

### LaTeX Not Rendering
If LaTeX symbols don't render:
- Check MATLAB version (R2014b or later recommended)
- Verify LaTeX is installed on your system
- Try `set(groot, 'defaultTextInterpreter', 'latex')`

### Export Failures
If figures don't export:
- Check write permissions in directory
- Verify disk space availability
- Check MATLAB print drivers: `print -drivers`

### Path Issues
If functions not found:
- Ensure you're in the correct directory
- Check that utility functions are in `ScriptsData/`
- Use `addpath` if needed:
  ```matlab
  addpath(fullfile(pwd, 'ScriptsData'))
  ```

## Technical Details

### setupLatexPlot.m
- Sets LaTeX interpreter for all text objects in a figure
- Handles: axes, labels, titles, legends, colorbars, text annotations
- Backward compatible with older MATLAB versions

### exportFigureHighQuality.m
- Supports multiple export formats simultaneously
- Auto-generates timestamp-based folder names
- Configures figure for optimal print quality
- Independent format exports (one failure doesn't affect others)

## Performance Notes

- Export time depends on figure complexity and DPI
- SVG export is fastest for vector graphics
- PNG at 900 DPI typical export time: 2-5 seconds per figure
- Batch exports may benefit from parallel processing

## Future Enhancements

Potential improvements for future versions:
- Batch export utility for multiple figures
- Custom color scheme templates
- Automatic figure optimization
- Export progress indicators
- Comparison plot utilities

## Support

For issues or questions:
1. Check this README first
2. Verify MATLAB version compatibility
3. Test utility functions independently
4. Check MATLAB documentation for `print` and `savefig`

## Version History

### Version 1.0 (November 22, 2025)
- Initial implementation
- LaTeX formatting for all plots
- High-quality export in PNG (900 DPI), SVG, FIG
- Timestamped export folders
- Comprehensive error handling

---

**Author**: Enhanced plotting system
**Date**: November 22, 2025
**MATLAB Compatibility**: R2014b and later recommended
**Repository**: Zaid_Renewable-Energy-Integration-Simscape
