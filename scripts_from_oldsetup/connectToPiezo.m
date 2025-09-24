% Instantiate controller class
global Controller

disp('Connecting to E709 controller...')


% Full paths to the DLL and header files
dllPath = fullfile(pwd, 'from_PI', 'PI_GCS2_DLL.dll');
hfilePath = fullfile(pwd, 'from_PI', 'PI_GCS2_DLL.h');
libAlias = 'PI_GCS2';

% Add path to all controller files
addpath(genpath('from_PI'));

% Make sure the DLL is loaded with correct .h file
if ~libisloaded(libAlias)
warning('off'); % suppress warnings during load
loadlibrary(dllPath, hfilePath, 'alias', libAlias);
warning('on');
end

% Initialize the controller structure/class
Controller = PI_GCS_Controller();
Controller.libalias = libAlias;  % <- make sure the object knows the alias
Controller.dllfunctions = libfunctions(libAlias);  % manually assign the available functions
% Connect to device via USB
devs = Controller.EnumerateUSB('E-709'); % mac edit
SN =regexp(devs, 'SN (\d+)', 'tokens','warnings');
Controller = Controller.ConnectUSB(char(SN{1}));

%     % RS232
%comPort = 3;          % Look at the Device Manager to get the correct COM Port.
%baudRate = 115200;    % Look at the manual to get the correct bau rate for your controller.
%Controller = Controller.ConnectRS232 ( comPort, baudRate );
%Controller = Controller.ConnectUSBWithBaudRate( comPort, baudRate );

Controller = Controller.InitializeController();

% Return axis handle
availableaxes = Controller.qSAI();
availableaxes = regexp(availableaxes,'[\w-]+','match');
axisname = availableaxes{1};

% Start closed-loop
Controller.SVO(axisname,1);


display('E709 controller connected.')

% % Move axis to position
% position = 20;
% Controller.MOV(axisname,position);
% 
% % Start a waveform scan
% Controller.WGC(1,1)
% Controller.WGC(1,5)
% Controller.WGO(1,1)

%% ScanImage

% Global microscope properties
objectiveResolution = 15;     % Resolution of the objective in microns/degree of scan angle

% Scanner systems
scannerNames = {'LinScanner'};     % Cell array of string names for each scan path in the microscope
scannerTypes = {'Linear'};     % Cell array indicating the type of scanner for each name. Current options: {'Resonant' 'Linear' 'SLM'}

% Simulated mode
simulated = false;     % Boolean for activating simulated mode. For normal operation, set to 'false'. For operation without NI hardware attached, set to 'true'.

% Optional components
components = {};     % Cell array of optional components to load. Ex: {'dabs.thorlabs.ECU1' 'dabs.thorlabs.BScope2'}

% Data file location
dataDir = '[MDF]\ConfigData';     % Directory to store persistent configuration and calibration data. '[MDF]' will be replaced by the MDF directory

% Custom Scripts
startUpScript = '';     % Name of script that is executed in workspace 'base' after scanimage initializes
shutDownScript = '';     % Name of script that is executed in workspace 'base' after scanimage exits

%% Shutters
% Shutter(s) used to prevent any beam exposure from reaching specimen during idle periods. Multiple
% shutters can be specified and will be assigned IDs in the order configured below.
shutterNames = {'Main Shutter'};     % Cell array specifying the display name for each shutter eg {'Shutter 1' 'Shutter 2'}
shutterDaqDevices = {'PXI1Slot3'};     % Cell array specifying the DAQ device or RIO devices for each shutter eg {'PXI1Slot3' 'PXI1Slot4'}
shutterChannelIDs = {'PFI12'};     % Cell array specifying the corresponding channel on the device for each shutter eg {'PFI12'}

shutterOpenLevel = 1;     % Logical or 0/1 scalar indicating TTL level (0=LO;1=HI) corresponding to shutter open state for each shutter line. If scalar, value applies to all shutterLineIDs
shutterOpenTime = 0.1;     % Time, in seconds, to delay following certain shutter open commands (e.g. between stack slices), allowing shutter to fully open before proceeding.

%% Beams
beamDaqDevices = {};     % Cell array of strings listing beam DAQs in the system. Each scanner set can be assigned one beam DAQ ex: {'PXI1Slot4'}

% Define the parameters below for each beam DAQ specified above, in the format beamDaqs(N).param = ...
beamDaqs(1).modifiedLineClockIn = '';     % one of {PFI0..15, ''} to which external beam trigger is connected. Leave empty for automatic routing via PXI/RTSI bus
beamDaqs(1).frameClockIn = '';     % one of {PFI0..15, ''} to which external frame clock is connected. Leave empty for automatic routing via PXI/RTSI bus
beamDaqs(1).referenceClockIn = '';     % one of {PFI0..15, ''} to which external reference clock is connected. Leave empty for automatic routing via PXI/RTSI bus
beamDaqs(1).referenceClockRate = 1e+07;     % if referenceClockIn is used, referenceClockRate defines the rate of the reference clock in Hz. Default: 10e6Hz

beamDaqs(1).chanIDs = [];     % Array of integers specifying AO channel IDs, one for each beam modulation channel. Length of array determines number of 'beams'.
beamDaqs(1).displayNames = {};     % Optional string cell array of identifiers for each beam
beamDaqs(1).voltageRanges = 1.5;     % Scalar or array of values specifying voltage range to use for each beam. Scalar applies to each beam.

beamDaqs(1).calInputChanIDs = [];     % Array of integers specifying AI channel IDs, one for each beam modulation channel. Values of nan specify no calibration for particular beam.
beamDaqs(1).calOffsets = [];     % Array of beam calibration offset voltages for each beam calibration channel
beamDaqs(1).calUseRejectedLight = false;     % Scalar or array indicating if rejected light (rather than transmitted light) for each beam's modulation device should be used to calibrate the transmission curve
beamDaqs(1).calOpenShutterIDs = [];     % Array of shutter IDs that must be opened for calibration (ie shutters before light modulation device).

%% Motors
% Motor used for X/Y/Z motion, including stacks.

motors(1).controllerType = '';     % If supplied, one of {'sutter.mp285', 'sutter.mpc200', 'thorlabs.mcm3000', 'thorlabs.mcm5000', 'scientifica', 'pi.e665', 'pi.e816', 'npoint.lc40x', 'bruker.MAMC'}.
motors(1).dimensions = '';     % Assignment of stage dimensions to SI dimensions. Can be any combination of X,Y,Z, and R.
motors(1).comPort = [];     % Integer identifying COM port for controller, if using serial communication
motors(1).customArgs = {};     % Additional arguments to stage controller. Some controller require a valid stageType be specified
motors(1).invertDim = '';     % string with one character for each dimension specifying if the dimension should be inverted. '+' for normal, '-' for inverted
motors(1).positionDeviceUnits = [];     % 1xN array specifying, in meters, raw units in which motor controller reports position. If unspecified, default positionDeviceUnits for stage/controller type presumed.
motors(1).velocitySlow = [];     % Velocity to use for moves smaller than motorFastMotionThreshold value. If unspecified, default value used for controller. Specified in units appropriate to controller type.
motors(1).velocityFast = [];     % Velocity to use for moves larger than motorFastMotionThreshold value. If unspecified, default value used for controller. Specified in units appropriate to controller type.
motors(1).moveCompleteDelay = [];     % Delay from when stage controller reports move is complete until move is actually considered complete. Allows settling time for motor
motors(1).moveTimeout = [];     % Default: 2s. Fixed time to wait for motor to complete movement before throwing a timeout error
motors(1).moveTimeoutFactor = [];     % (s/um) Time to add to timeout duration based on distance of motor move command

%% FastZ
% FastZ hardware used for fast axial motion, supporting fast stacks and/or volume imaging

actuators(1).controllerType = '';     % If supplied, one of {'pi.e665', 'pi.e816', 'npoint.lc40x', 'analog'}.
actuators(1).comPort = [];     % Integer identifying COM port for controller, if using serial communication
actuators(1).customArgs = {};     % Additional arguments to stage controller
actuators(1).daqDeviceName = '';     % String specifying device name used for FastZ control; Specify SLM Scanner name if FastZ device is a SLM
actuators(1).frameClockIn = '';     % One of {PFI0..15, ''} to which external frame trigger is connected. Leave empty for automatic routing via PXI/RTSI bus
actuators(1).cmdOutputChanID = [];     % AO channel number (e.g. 0) used for analog position control
actuators(1).sensorInputChanID = [];     % AI channel number (e.g. 0) used for analog position sensing
actuators(1).commandVoltsPerMicron = 0.1;     % Conversion factor for desired command position in um to output voltage
actuators(1).commandVoltsOffset = 0;     % Offset in volts for desired command position in um to output voltage
actuators(1).sensorVoltsPerMicron = [];     % Conversion factor from sensor signal voltage to actuator position in um. Leave empty for automatic calibration
actuators(1).sensorVoltsOffset = [];     % Sensor signal voltage offset. Leave empty for automatic calibration
actuators(1).maxCommandVolts = [];     % Maximum allowable voltage command
actuators(1).maxCommandPosn = [];     % Maximum allowable position command in microns
actuators(1).minCommandVolts = [];     % Minimum allowable voltage command
actuators(1).minCommandPosn = [];     % Minimum allowable position command in microns
actuators(1).optimizationFcn = '';     % Function for waveform optimization
actuators(1).affectedScanners = {};     % If this actuator only changes the focus for an individual scanner, enter the name

% Field curvature correction params
fieldCurveZ0 = 0;
fieldCurveRx0 = 0;
fieldCurveRy0 = 0;
fieldCurveZ1 = 0;
fieldCurveRx1 = 0;
fieldCurveRy1 = 0;

