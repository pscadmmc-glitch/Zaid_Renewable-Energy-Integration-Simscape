# 📚 Comprehensive Guide: Renewable Energy Integration with Simscape
## All Scenarios and Workflows

---

## 📋 Table of Contents

1. [Getting Started](#getting-started)
2. [Solar PV Plant with Battery Storage (GFM-BESS)](#1-solar-pv-plant-with-battery-storage-gfm-bess)
3. [Wind Farm with Grid-Forming Controls](#2-wind-farm-with-grid-forming-controls)
4. [HVDC Systems](#3-hvdc-systems)
5. [Admittance Scanning and Stability Analysis](#4-admittance-scanning-and-stability-analysis)
6. [Running Tests](#5-running-tests)
7. [Advanced Topics](#6-advanced-topics)

---

## Getting Started

### Prerequisites
- **MATLAB R2024b** or later
- **Simscape** and **Simscape Electrical** toolboxes
- **Control System Toolbox** (for stability analysis)
- **Signal Processing Toolbox** (for admittance scanning)

### Initial Setup
1. Clone or download the repository
2. Open MATLAB and navigate to the repository folder
3. Open the MATLAB project: `RenewableEnergyIntegrationSimscape.prj`
4. Run the startup script to initialize paths and parameters

```matlab
% The project automatically runs startup.mlx when opened
% Or manually run:
open('ScriptsData/startup.mlx')
```

---

## 1. Solar PV Plant with Battery Storage (GFM-BESS)

### 📁 Location
- **Model:** `Models/PVPlant/BatteryStoragePVPlantGFM.slx`
- **Scripts:** `ScriptsData/PVPlant/`
- **Main Documentation:** `ScriptsData/PVPlant/BatteryStoragePVPlantGFMMainPage.mlx`

### System Description
A **100 MW solar PV plant** integrated with a **50 MW / 25 MWh Grid-Forming Battery Energy Storage System (GFM-BESS)**. The system demonstrates:
- Grid-forming control strategies
- IEEE 2800 standard compliance
- Fault ride-through capabilities
- Frequency and voltage support

### Available Scenarios

#### Scenario 1: PV Power Variation
**Purpose:** Test system response to solar irradiance changes

```matlab
% Setup and run
BatteryStoragePVPlantGFMParameters;
scenario = 1;
SimulationTime = 5;
t_event = 2; % Event occurs at 2 seconds
params = BatteryStoragePVPlantGFMSettingScenario(scenario, SimulationTime, t_event);

% Open model and simulate
open_system('Models/PVPlant/BatteryStoragePVPlantGFM.slx');
sim('Models/PVPlant/BatteryStoragePVPlantGFM.slx');

% Plot results
BatteryStoragePVPlantGFMplot;
```

**What happens:**
- PV power changes at t_event (e.g., from 100 MW to 50 MW)
- BESS automatically compensates to maintain grid stability
- Tests power balancing capability

---

#### Scenario 2: Load Step Change
**Purpose:** Test system response to sudden load variations

```matlab
scenario = 2;
SimulationTime = 5;
t_event = 2;
params = BatteryStoragePVPlantGFMSettingScenario(scenario, SimulationTime, t_event);
```

**What happens:**
- Local load increases/decreases at t_event
- BESS provides instantaneous power support
- Grid-forming control maintains voltage and frequency

---

#### Scenario 3: Grid Outage (Islanding)
**Purpose:** Test islanded operation capability

```matlab
scenario = 3;
SimulationTime = 5;
t_event = 2;
params = BatteryStoragePVPlantGFMSettingScenario(scenario, SimulationTime, t_event);
```

**What happens:**
- Grid disconnection at t_event
- GFM-BESS transitions to islanded mode
- Maintains local voltage and frequency
- Tests black-start capability

---

#### Scenario 4: Symmetrical Fault with Clearing
**Purpose:** Test fault ride-through (FRT) compliance per IEEE 2800

```matlab
scenario = 4;
SimulationTime = 5;
t_event = 2;
params = BatteryStoragePVPlantGFMSettingScenario(scenario, SimulationTime, t_event);
```

**What happens:**
- Three-phase fault at 99% of transmission line
- Fault occurs at t_event
- Fault cleared after 100 ms
- Tests voltage recovery and reactive current injection
- Verifies IEEE 2800 compliance

**IEEE 2800 Compliance Tests:**
- Voltage support during fault
- Reactive current injection (Iq injection)
- Post-fault voltage recovery
- Frequency support capability

---

#### Scenario 5: Permanent Fault
**Purpose:** Test behavior during uncleared faults

```matlab
scenario = 5;
SimulationTime = 5;
t_event = 2;
params = BatteryStoragePVPlantGFMSettingScenario(scenario, SimulationTime, t_event);
```

**What happens:**
- Fault occurs but is NOT cleared
- System must ride through extended fault condition
- Tests protective relay coordination
- Validates current limiting strategies

---

#### Scenario 6: Extended Permanent Fault
**Purpose:** Long-duration fault analysis

```matlab
scenario = 6;
SimulationTime = 10;
% Fault at 1.5 seconds (hardcoded in scenario)
params = BatteryStoragePVPlantGFMSettingScenario(scenario, SimulationTime, 0);
```

---

### Grid-Forming vs Grid-Following Comparison

```matlab
% Run comparison script
BatteryStoragePVPlantGFMComparisonGFLvsGFM;
```

**Compares:**
- Transient response (GFM vs GFL)
- Voltage/frequency regulation
- Fault ride-through performance
- Stability margins

---

### Short Circuit Ratio (SCR) Analysis

```matlab
% Calculate SCR
BatteryStoragePVPlantGFMSCRCal;
```

**Tests different grid strengths:**
- Strong grid: SCR > 3
- Weak grid: SCR < 3
- Very weak grid: SCR < 1.5

---

### IEEE 2800 Compliance Verification

The system includes automated compliance checking:

```matlab
% View compliance tables
open('ScriptsData/PVPlant/BatteryStoragePVPlantGFMTableComplianceIEEEStd.xlsx');
open('ScriptsData/PVPlant/BatteryStoragePVPlantGFMTRideThroughF.xlsx'); % Frequency
open('ScriptsData/PVPlant/BatteryStoragePVPlantGFMTRideThroughV.xlsx'); % Voltage
```

**Compliance Tests Include:**
- **Voltage Ride-Through:** Per IEEE 2800-2022 Table 6
- **Frequency Ride-Through:** Per IEEE 2800-2022 Table 8
- **Active Power Control:** Droop and inertial response
- **Reactive Power Control:** Voltage support and Iq injection
- **Harmonic Distortion:** THD limits per IEEE 519

---

### Plotting Enhanced Results

```matlab
% High-quality power plots
BatteryStoragePVPlantGFMplotCurve_power;

% Voltage and frequency response
BatteryStoragePVPlantGFMplotCurve_voltage_frequency;

% THD bar chart
BatteryStoragePVPlantGFMplotTHDbar;
```

---

## 2. Wind Farm with Grid-Forming Controls

### 📁 Location
- **Model:** `Models/Wind Model/WindFarmGFMControl.slx`
- **Scripts:** `ScriptsData/Wind Model/`
- **Main Documentation:** `ScriptsData/Wind Model/MWWindFarmwithGridformingControls.mlx`

### System Description
**Type-4 wind generators** (full-scale converter) with two grid-forming strategies:
1. **GGFM (Generic Grid-Forming):** DC-link voltage regulation
2. **MGFM (Modified Grid-Forming):** Turbine inertia emulation

---

### Available Models and Scenarios

#### Model 1: Wind Farm with GFM Control (Main Model)
**Model:** `WindFarmGFMControl.slx`

```matlab
% Load parameters
WindFarmGFMControlParameters;

% Open and simulate
open_system('Models/Wind Model/WindFarmGFMControl.slx');
sim('Models/Wind Model/WindFarmGFMControl.slx');

% Plot results
WindGFMControlPlotresults;
```

---

#### Model 2: GGFM - DC Link Regulation
**Model:** `WindGFMCap.slx`

**Features:**
- Grid-forming control using DC capacitor as energy buffer
- Fast frequency response
- No dependency on mechanical turbine inertia

```matlab
open_system('Models/Wind Model/WindGFMCap.slx');
```

---

#### Model 3: MGFM - Turbine Inertia Emulation
**Model:** `WindGFMTurbineInertia.slx`

**Features:**
- Emulates turbine rotational inertia
- Improved frequency support during transients
- Coordinated control with turbine pitch

```matlab
open_system('Models/Wind Model/WindGFMTurbineInertia.slx');
```

---

#### Model 4: GFL with MPP Tracking
**Model:** `WindGFLMpp.slx`

**Features:**
- Traditional grid-following control
- Maximum Power Point (MPP) tracking
- Used as baseline for comparison

```matlab
open_system('Models/Wind Model/WindGFLMpp.slx');
```

---

### Test Scenarios

#### Scenario A: Fault Ride-Through (FRT)
**Purpose:** Test wind turbine behavior during grid faults

```matlab
% Configure FRT test
WindFarmGFMControlParameters;

% Simulate fault at t=2s, cleared at t=2.15s
% Results show:
% - Active/reactive power injection
% - DC-link voltage stability
% - Rotor speed variation
% - Grid voltage recovery

% Plot curves
WindFarmGFMControlplotCurvepower;
WindFarmGFMControlplotCurvevoltagefrequency;
```

---

#### Scenario B: GFM vs GFL Comparison
**Purpose:** Compare grid-forming and grid-following performance

```matlab
% Run comparison
GFMvsGFLWindControl;
comparisonGFMvsGFL;

% View comparison data
open('ScriptsData/Wind Model/GFMvsGFLwithSCR.xlsx');
```

**Comparison Metrics:**
- Frequency nadir during disturbances
- Voltage recovery time
- Active power ramping
- Stability under weak grids (low SCR)

---

#### Scenario C: SCR Variation Studies
**Purpose:** Test performance under varying grid strengths

```matlab
% Calculate wind farm SCR
windSCR;
WindSCRCal;

% Test different SCR values
% SCR = 5: Strong grid
% SCR = 3: Medium grid
% SCR = 1.5: Weak grid
% SCR < 1.5: Very weak grid
```

---

#### Scenario D: Wind Speed Variations
**Purpose:** Test dynamic response to wind changes

```matlab
% Variable wind speed profile
% Tests power tracking and control response
ComparisonGFMWithGFL;
```

---

### Enhanced Plotting

```matlab
% Power curves (P, Q vs time)
WindFarmGFMControlplotCurvepower;

% Voltage and frequency response
WindFarmGFMControlplotCurvevoltagefrequency;

% Log-scale plotting
logsWindGFMControlPlotresults;
```

---

## 3. HVDC Systems

### 3.1 Multi-Terminal HVDC (MTHVDC)

#### 📁 Location
- **Model:** `Models/HVDC/HVDCMTGW.slx`
- **Scripts:** `ScriptsData/HVDC/MultiTerminalHVDC/`
- **Documentation:** `ScriptsData/HVDC/MultiTerminalHVDC/MTHVDCModelDescription.mlx`

#### System Description
**Multi-terminal VSC-HVDC system** connecting offshore wind farms to onshore grids:
- Multiple offshore wind farm terminals
- Flexible DC grid topology
- Grid-forming capability for offshore AC collection
- ±320 kV DC voltage
- Modular Multilevel Converter (MMC) technology

#### Setup and Run

```matlab
% Load MTHVDC parameters
cd('ScriptsData/HVDC/MultiTerminalHVDC');
MTHVDCparameters;

% Open model
open_system('Models/HVDC/HVDCMTGW.slx');
sim('Models/HVDC/HVDCMTGW.slx');
```

---

#### Available Scenarios

**Scenario 1: Normal Operation**
- Offshore wind power transmission
- DC voltage regulation across terminals
- Active power balancing

**Scenario 2: Onshore Grid Fault**
- AC fault on onshore grid
- HVDC response and FRT
- Post-fault power recovery

**Scenario 3: Offshore Grid Fault**
- Fault in offshore AC collection system
- GFM control maintains island stability
- DC side protection

**Scenario 4: DC Line Fault**
- DC pole-to-ground fault
- DC circuit breaker operation
- System reconfiguration

**Scenario 5: Variable Wind Power**
- Dynamic wind power changes
- HVDC power flow control
- Terminal coordination

**Scenario 6: Terminal Outage**
- Loss of one HVDC terminal
- Power redistribution
- Remaining system stability

---

### 3.2 VSC-HVDC Admittance Scan and Stability Analysis

#### 📁 Location
- **Model:** `Models/Admittance Scan/HVDCScan.slx`
- **Scripts:** `ScriptsData/HVDC/ScanOfVSCHVDC/`
- **Documentation:** `ScriptsData/HVDC/ScanOfVSCHVDC/VSCHVDCScanandStabilityAnalysis.mlx`

#### System Description
**Two-terminal VSC-HVDC** linking offshore wind farm to onshore grid with admittance-based stability assessment

#### Setup and Run

```matlab
% Navigate to HVDC scan folder
cd('ScriptsData/HVDC/ScanOfVSCHVDC');

% Configure admittance scanner
configureAdmittanceScanner;

% Set simulation for scan
setSimulationforScan;

% Run admittance estimation
estimateAdmittances;
```

---

#### Analysis Tools

**1. Admittance Estimation**
```matlab
% Estimate system admittance matrix
estimateAdmittances;
```

**2. Bode Determinant Plot**
```matlab
% Compute and plot determinant
bodeDeterminant;
computeDet;
```

**3. Generalized Nyquist Criterion**
```matlab
% Nyquist plot with crossing detection
generalizedNyquistPlotwithCrossing;
encirclementNyquistPlot;
```

**4. Eigenvalue and Bode Analysis**
```matlab
% Combined eigenvalue and frequency response
plotEigLBode;
```

---

#### Stability Scenarios

**Scenario A: Baseline Stability**
- Nominal operating point
- Assess stability margins
- Identify resonance frequencies

**Scenario B: Weak Grid Connection**
- Vary grid SCR
- Track eigenvalue movement
- Detect instability onset

**Scenario C: Controller Parameter Sweep**
- Vary PLL bandwidth
- Vary current controller gains
- Assess impact on stability

**Scenario D: Operating Point Variation**
- Different power levels
- Different voltage levels
- Stability map generation

---

### General HVDC Utilities

```matlab
% Load general HVDC parameters
open('ScriptsData/HVDC/HVDCParameters.mlx');

% Plot HVDC waveforms
plotHVDC;
plotPowerCurves;

% Sweep turbine parameters
sweepTurbine;

% Offshore wind configuration
offshoreWind;
```

---

## 4. Admittance Scanning and Stability Analysis

### 📁 Location
- **Models:** `Models/Admittance Scan/`
- **Scripts:** `ScriptsData/Admittance Scan/`
- **Main Documentation:** `ScriptsData/Admittance Scan/AdmittanceScanofIBRsDescription.mlx`

### Available Tools and Models

---

### 4.1 PRBS-Based Admittance Scanning

#### Model: AdmittanceScanPRBS.slx

**Purpose:** Frequency-domain admittance measurement using Pseudo-Random Binary Sequence (PRBS) injection

```matlab
% Load parameters
Admittancescanparameters;

% Configure scan
AdmittanceScanner;

% Run PRBS-based scan
admittancescanPRBS;

% For DC admittance
dcAdmittancescanPRBS;
```

---

### 4.2 Test Harness for Custom IBR

#### Model: TestHarness.slx
**Documentation:** `TestHarnessDescription.mlx`

**Purpose:** Generic test bench for analyzing custom inverter-based resources

```matlab
% Load test harness parameters
Harnessparm;

% Open test harness
open_system('Models/Admittance Scan/TestHarness.slx');

% Run custom IBR tests
sim('TestHarness.slx');
```

---

### 4.3 Scanning Blocks

**Available Models:**
1. **ScanBlock.slx:** AC admittance scanning
2. **ScanBlockwithDC.slx:** AC+DC admittance scanning
3. **ScanDc.slx:** DC-side admittance only

```matlab
% Use appropriate scan block
open_system('Models/Admittance Scan/ScanBlock.slx');
```

---

### Plotting Functions

**DQ-Frame Admittance Plots:**
```matlab
% D-axis admittance
plotAdmittanceD;

% Q-axis admittance
plotAdmittanceQ;

% Combined DQ plot
plotAdmittanceDQdc;
```

**DC Admittance Plots:**
```matlab
% DC admittance (d-component)
plotAdmittanceDCd;

% DC admittance (q-component)
plotAdmittanceDCq;

% General DC admittance
plotAdmittanceDC;
```

---

### Analysis Workflows

#### Workflow 1: IBR Stability Assessment
```matlab
% 1. Load IBR model
% 2. Configure scan parameters
AdmittanceScanParameters; % MLX file - open and configure

% 3. Run admittance scan
admittancescanPRBS;

% 4. Plot results
plotAdmittanceD;
plotAdmittanceQ;

% 5. Analyze for resonances and instabilities
% Look for:
% - High magnitude peaks (resonances)
% - Negative resistance regions (potential instability)
% - Phase crossings near critical frequencies
```

---

#### Workflow 2: FFT Power Analysis
```matlab
% Fast Fourier Transform of power signals
fFTPower;

% Identifies harmonic content and oscillations
```

---

### Test Scenarios

**Scenario 1: Single IBR Stability**
- Connect one IBR to grid
- Scan admittance across frequency range (0.1 Hz - 1000 Hz)
- Identify resonance modes

**Scenario 2: Multi-IBR Interaction**
- Multiple IBRs on same grid
- Detect mode interactions
- Assess collective stability

**Scenario 3: Grid Impedance Variation**
- Sweep grid impedance (SCR variation)
- Track stability boundary
- Generate stability maps

**Scenario 4: Controller Tuning Verification**
- Before/after controller changes
- Verify improved stability margins
- Document phase/gain margins

---

## 5. Running Tests

### 📁 Location: `Tests/`

The repository includes comprehensive unit and system tests.

---

### Unit Tests

**PV Plant BESS:**
```matlab
% Run PV plant unit tests
UnitTestrunnerPVPlantBESSGFMControl;

% Or individual test
runtests('BatteryStoragePVPlantGFMControlUnitTest');
```

**Wind Farm GFM:**
```matlab
% Run wind farm unit tests
UnitTestrunnerWindFarmGFMControl;

% Individual test
runtests('WindFarmGFMControlUnitTest');
```

**Multi-Terminal HVDC:**
```matlab
% Run MTHVDC unit tests
UnitTestrunnerMTHVDC;

% Individual test
runtests('MTHVDCUnitTest');
```

**Admittance Scan PRBS:**
```matlab
% Run admittance scan tests
UnitTestrunnerAdmittanceSCANPRBS;

% Individual test
runtests('AdmittanceScanPRBSUnitTest');
```

**Admittance Scan HVDC:**
```matlab
% Run HVDC scan tests
UnitTestrunnerAdmittanceSCANHVDC;

% Individual test
runtests('AdmittanceScanHVDCUnitTest');
```

---

### System Tests

**Wind Farm System Test:**
```matlab
% Comprehensive system-level tests
runtests('WindFarmGFMControlSystemTest');
```

---

### Running All Tests

```matlab
% Run all tests in Tests folder
results = runtests('Tests');

% Display summary
table(results)
```

---

## 6. Advanced Topics

### 6.1 Enhanced Plotting and Export

All plotting functions now support LaTeX formatting and high-quality export:

```matlab
% Setup LaTeX-style plots
setupLatexPlot;

% Export high-quality figures
exportFigureHighQuality(gcf, 'filename', 'png'); % or 'pdf', 'eps'
```

**Available formats:**
- PNG (300 DPI)
- PDF (vector graphics)
- EPS (publication quality)

---

### 6.2 Custom Scenario Development

#### Creating Custom PV Plant Scenarios

Edit `BatteryStoragePVPlantGFMSettingScenario.m` to add new scenarios:

```matlab
function [y] = BatteryStoragePVPlantGFMSettingScenario(n,SimulationTime,t_event)
switch n
    case 7  % Your new scenario
        Fault_distance = 0.5;  % Mid-line fault
        Fault_instant = t_event;
        Fault_duration = 0.15;  % Longer fault
        Load_change_instant = SimulationTime + 0.1;
        PVpower_change_instant = t_event + 1;  % PV change 1s after fault
        Grid_outage_instant = SimulationTime + 0.1;
        Line_trip = SimulationTime + 0.1;
    % ... add more cases
end
y = [Fault_distance, Fault_instant, Fault_duration, ...
     Load_change_instant, PVpower_change_instant, ...
     Grid_outage_instant, Line_trip];
end
```

---

### 6.3 Parameter Sensitivity Studies

**Example: SCR Sweep**
```matlab
SCR_values = [1.2, 1.5, 2.0, 3.0, 5.0, 10.0];
results = struct();

for i = 1:length(SCR_values)
    % Set SCR
    SCR = SCR_values(i);

    % Update grid impedance
    BatteryStoragePVPlantGFMParameters;

    % Simulate
    sim('BatteryStoragePVPlantGFM');

    % Store results
    results(i).SCR = SCR;
    results(i).sim = simOut;
end

% Analyze sensitivity
```

---

### 6.4 Compliance Testing Automation

**IEEE 2800 Automated Testing:**
```matlab
% The models include built-in compliance checking
% Results automatically saved to Excel files:
% - BatteryStoragePVPlantGFMTableComplianceIEEEStd.xlsx
% - BatteryStoragePVPlantGFMTRideThroughF.xlsx (Frequency)
% - BatteryStoragePVPlantGFMTRideThroughV.xlsx (Voltage)

% View compliance summary
compliance_data = readtable('ScriptsData/PVPlant/BatteryStoragePVPlantGFMTableComplianceIEEEStd.xlsx');
disp(compliance_data);
```

---

### 6.5 Integrating with Real-Time Simulation

The models are structured for Hardware-in-the-Loop (HIL) deployment:

**Preparation Steps:**
1. Set fixed-step solver (e.g., ode4, ode5)
2. Configure sample times for real-time constraints
3. Use Simulink Coder for code generation
4. Deploy to real-time target (Speedgoat, OPAL-RT, etc.)

```matlab
% Configure for real-time
set_param(model, 'Solver', 'ode4');
set_param(model, 'FixedStep', '50e-6'); % 50 microseconds
set_param(model, 'EnableMultiTasking', 'on');
```

---

## 7. Quick Reference Tables

### Scenario Quick Reference

#### PV Plant with BESS Scenarios

| Scenario | Event Type | Event Time | Duration | Purpose |
|----------|------------|------------|----------|---------|
| 1 | PV Power Change | t_event | - | Solar irradiance variation |
| 2 | Load Step | t_event | - | Load demand change |
| 3 | Grid Outage | t_event | - | Islanding operation |
| 4 | Fault (cleared) | t_event | 100 ms | FRT compliance |
| 5 | Fault (permanent) | t_event | Permanent | Extended fault |
| 6 | Fault (permanent) | 1.5 s | Permanent | Long-term fault |

---

#### Wind Farm Test Cases

| Test Case | Model | Control | Purpose |
|-----------|-------|---------|---------|
| GFM-GGFM | WindGFMCap.slx | DC-Link Reg | Fast frequency response |
| GFM-MGFM | WindGFMTurbineInertia.slx | Inertia Emulation | Improved inertia support |
| GFL-MPP | WindGFLMpp.slx | Grid-Following | Baseline comparison |
| Combined | WindFarmGFMControl.slx | Switchable | Comprehensive analysis |

---

#### HVDC Test Scenarios

| Scenario | System | Test Condition | Analysis |
|----------|--------|----------------|----------|
| MTHVDC-1 | Multi-Terminal | Normal operation | Power flow control |
| MTHVDC-2 | Multi-Terminal | Onshore fault | FRT capability |
| MTHVDC-3 | Multi-Terminal | Offshore fault | GFM response |
| MTHVDC-4 | Multi-Terminal | DC fault | Protection scheme |
| HVDC-Scan-1 | Two-Terminal | Admittance scan | Stability assessment |
| HVDC-Scan-2 | Two-Terminal | Weak grid | SCR variation |

---

### File Structure Reference

```
Renewable-Energy-Integration-Simscape/
│
├── Models/
│   ├── PVPlant/
│   │   ├── BatteryStoragePVPlantGFM.slx (Main PV+BESS model)
│   │   ├── PVInverterGFL.slx
│   │   └── PVcontroller.slx
│   │
│   ├── Wind Model/
│   │   ├── WindFarmGFMControl.slx (Main wind model)
│   │   ├── WindGFMCap.slx (GGFM)
│   │   ├── WindGFMTurbineInertia.slx (MGFM)
│   │   ├── WindGFLMpp.slx (GFL)
│   │   └── gfmWind.slx
│   │
│   ├── HVDC/
│   │   ├── HVDCMTGW.slx (Multi-terminal)
│   │   ├── BypoleHVDC.slx
│   │   ├── HVDCSTATION.slx
│   │   └── [other HVDC components]
│   │
│   └── Admittance Scan/
│       ├── AdmittanceScanPRBS.slx
│       ├── HVDCScan.slx
│       ├── ScanBlock.slx
│       ├── ScanBlockwithDC.slx
│       └── TestHarness.slx
│
├── ScriptsData/
│   ├── PVPlant/ (PV scripts and parameters)
│   ├── Wind Model/ (Wind scripts and parameters)
│   ├── HVDC/
│   │   ├── MultiTerminalHVDC/
│   │   └── ScanOfVSCHVDC/
│   ├── Admittance Scan/
│   └── [Utility functions]
│
├── Tests/ (Unit and system tests)
├── Data/ (Simulation data and results)
├── Pictures/ (Documentation images)
└── README.md
```

---

## 8. Troubleshooting

### Common Issues

**Issue 1: Model doesn't run**
```matlab
% Solution: Ensure parameters are loaded
BatteryStoragePVPlantGFMParameters; % For PV model
WindFarmGFMControlParameters; % For wind model
MTHVDCparameters; % For HVDC model
```

**Issue 2: Simulation runs slowly**
```matlab
% Solution: Adjust solver settings
set_param(model, 'SolverType', 'Fixed-step');
set_param(model, 'Solver', 'ode4');
set_param(model, 'FixedStep', 'auto');
```

**Issue 3: Plots not generated**
```matlab
% Solution: Check if Simulation Data Inspector has data
% Or use logging signals directly from workspace
```

**Issue 4: Admittance scan fails**
```matlab
% Solution: Check PRBS amplitude and frequency range
% Ensure system is at steady state before scan
% Verify Signal Processing Toolbox is installed
```

---

## 9. Standards Compliance Reference

### IEEE 2800-2022
Grid-forming inverter-based resources

**Tested Requirements:**
- Voltage ride-through (Section 6.5.1)
- Frequency ride-through (Section 6.5.2)
- Active power control (Section 6.6)
- Reactive power control (Section 6.7)
- Harmonics and interharmonics (Section 6.8)

### IEEE 519
Harmonic limits

**Verified Metrics:**
- Total Harmonic Distortion (THD)
- Individual harmonic limits

### IEC 61400-21
Wind turbine grid compliance

**Applicable Tests:**
- Power quality assessment
- FRT capability
- Active power control

---

## 10. Additional Resources

### Documentation Files
- **Main Overview:** `RenewableEnergyIntegrationDesignOverview.mlx`
- **PV Plant:** `BatteryStoragePVPlantGFMMainPage.mlx`
- **Wind Farm:** `MWWindFarmwithGridformingControls.mlx`
- **MTHVDC:** `MTHVDCModelDescription.mlx`
- **HVDC Scan:** `VSCHVDCScanandStabilityAnalysis.mlx`
- **Admittance Scan:** `AdmittanceScanofIBRsDescription.mlx`

### MathWorks Resources
- [File Exchange](https://www.mathworks.com/matlabcentral/fileexchange/123870)
- [MATLAB Online](https://matlab.mathworks.com/open/github/v1?repo=simscape/Renewable-Energy-Integration-Simscape)

---

## Summary of All Runnable Scenarios

| # | Category | Scenario | Main Script/Model | Approximate Runtime |
|---|----------|----------|-------------------|---------------------|
| 1 | PV+BESS | PV power variation | Scenario 1 | ~2 min |
| 2 | PV+BESS | Load step | Scenario 2 | ~2 min |
| 3 | PV+BESS | Grid outage (islanding) | Scenario 3 | ~2 min |
| 4 | PV+BESS | Fault with clearing | Scenario 4 | ~2 min |
| 5 | PV+BESS | Permanent fault | Scenario 5 | ~3 min |
| 6 | PV+BESS | Extended fault | Scenario 6 | ~5 min |
| 7 | PV+BESS | GFM vs GFL comparison | ComparisonGFLvsGFM | ~5 min |
| 8 | PV+BESS | SCR sweep | BatteryStoragePVPlantGFMSCRCal | ~10 min |
| 9 | Wind | GGFM FRT test | WindGFMCap.slx | ~3 min |
| 10 | Wind | MGFM FRT test | WindGFMTurbineInertia.slx | ~3 min |
| 11 | Wind | GFL baseline | WindGFLMpp.slx | ~3 min |
| 12 | Wind | GFM vs GFL comparison | GFMvsGFLWindControl | ~6 min |
| 13 | Wind | SCR variation | WindSCRCal | ~8 min |
| 14 | HVDC | MT-HVDC normal op | HVDCMTGW.slx | ~4 min |
| 15 | HVDC | MT-HVDC onshore fault | HVDCMTGW.slx (config) | ~4 min |
| 16 | HVDC | MT-HVDC offshore fault | HVDCMTGW.slx (config) | ~4 min |
| 17 | HVDC | VSC-HVDC adm. scan | VSCHVDCScanandStabilityAnalysis.mlx | ~10 min |
| 18 | Adm.Scan | PRBS IBR scan | admittancescanPRBS | ~8 min |
| 19 | Adm.Scan | DC admittance scan | dcAdmittancescanPRBS | ~8 min |
| 20 | Adm.Scan | Test harness custom IBR | TestHarness.slx | Variable |

---

**Total Unique Scenarios: 20+**

**End of Comprehensive Guide**

---

*For questions, issues, or contributions, please refer to the repository README or contact the maintainers.*

*Last Updated: 2024*
