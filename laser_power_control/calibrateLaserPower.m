function calibrateLaserPower(theta_range, step_size, wavelengths)
% Calibrate waveplate angle (theta) vs objective power using PM100D + PDA.
% Uses dabs.ni.daqmx for NI USB-6001 (no MATLAB DAQ toolbox).
%
% Maps:
%   1) theta -> objective power (mW) via quadratic fit (poly2)
%   2) photodiode voltage (V, USB-6001) -> power (mW) via linear slope
%
% OUTPUT:
%   powerCalibrationData_CURRENT.mat at:
%   C:\Users\debivort lab\Documents\MATLAB\laser_power_control\powerCalibrationData_CURRENT.mat
%
% USAGE:
%   calibrateLaserPower()                      % defaults
%   calibrateLaserPower([162 168], 0.05, 930)  % explicit

% -------- defaults --------
if nargin < 1 || isempty(theta_range), theta_range = [162 168]; end
if nargin < 2 || isempty(step_size),   step_size   = 0.05;      end
if nargin < 3 || isempty(wavelengths), wavelengths = 930;       end

AI_CHANNEL = 0;                         % USB-6001 channel carrying PDA100A
theta = theta_range(1):step_size:theta_range(2);

% -------- globals --------
global USB6001 USB6001AnalogInputs PM100D powerController %#ok<NUSED>

% -------- connect USB-6001 (for PDA100A) via dabs --------
try
    if isempty(USB6001AnalogInputs) || ~isvalid(USB6001AnalogInputs)
        disp('Connecting to USB-6001 (photodiode) via dabs...');
        % Use your dabs-based connector; stores proxy in global USB6001AnalogInputs
        USB6001 = connectToUSB6001_dabs(AI_CHANNEL); %#ok<NASGU>
    end
catch ME
    error('Could not connect to USB-6001 (dabs): %s', ME.message);
end

% -------- connect PM100D (VISA-USB) --------
try
    if isempty(PM100D) || ~strcmp(get(PM100D,'Status'),'open')
        disp('Connecting to Thorlabs PM100D...');
        connectToPowerMeterConsole(1);
    end
catch
    error(['Unable to connect to PM100D. Ensure it is powered and visible to VISA. ', ...
           'Run visadevlist to verify.']);
end

% -------- connect Half-Wave Plate motor (serialport) --------
try
    if isempty(powerController) || ~isa(powerController,'serialport') || ~isvalid(powerController)
        disp('Connecting to PR50CC half-wave plate motor...');
        connectToHalfWavePlateMotor(1);    % homes only if needed
    end
catch ME
    error('Failed to connect to PR50CC: %s', ME.message);
end

% -------- prep PM100D --------
flushinput(PM100D); pause(0.3);           % clear old bytes (VISA object)
fprintf(PM100D,"CONF:POW\n");             % measure POWER
fprintf(PM100D,"SENS:POW:RANG:AUTO 1\n"); % autorange
fprintf(PM100D,"SENS:AVER:STAT 1\n");     % optional averaging
fprintf(PM100D,"SENS:AVER:COUN 10\n");
pause(0.5);

% -------- UI --------
hFig = figure('Color','w','Position',[215,175,1475,710]);
[hTheta, hDiode] = render_fig(hFig, theta_range);
uiwait(msgbox(sprintf([ ...
    'Calibration will sweep the half-wave plate while reading the PM100D and PDA.\n' ...
    'Make sure the power sensor is near the objective and beam path is stable.\n' ...
    'Click OK to begin.']), ...
    'POWER CALIBRATION','modal'));
disp('Beginning calibration...');

% -------- loop over wavelengths --------
wct = 0;
powerCalibrationData = struct([]); %#ok<NASGU>

for lambda = reshape(sort(wavelengths),1,[])
    wct = wct + 1;

    % PM100D wavelength correction (we do not verify laser λ)
    fprintf(PM100D,"SENS:CORR:WAV %d\n", lambda);
    pause(0.1);

    % Update plot titles
    title(hTheta, sprintf('Objective power vs theta  (\\lambda = %d nm)', lambda));
    title(hDiode, sprintf('Photodiode (V) vs objective power (mW)  (\\lambda = %d nm)', lambda));

    % data buffer for this wavelength
    raw_data = zeros(numel(theta), 4);   % [lambda, theta, PD_V, mW]
    ct = 0;

    for k = 1:numel(theta)
        ct = ct + 1;

        % Move HWP to absolute angle
        writeline(powerController, sprintf('1PA%3.3f', theta(k)));
        % Wait until stage ready
        while ~isReady_serialport(powerController), pause(0.02); end
        pause(0.05);  % brief settle

        % Read photodiode (USB-6001 via dabs proxy)
        AIdata = USB6001AnalogInputs.inputSingleScan;   % row vector
        pdV = AIdata(AI_CHANNEL+1);

        % Read PM100D power (Watts -> mW)
        fprintf(PM100D,"READ?\n");
        pW = str2double(fscanf(PM100D));
        p_mW = 1e3 * pW;

        raw_data(ct,:) = [lambda, theta(k), pdV, p_mW];

        % live plot updates
        plot(hTheta, theta(k), p_mW, 'o');   % left: theta -> mW
        plot(hDiode, pdV,      p_mW, 'o');   % right: PD V -> mW
        drawnow;
    end

    % -------- fits --------
    mdl = fit(raw_data(:,2), raw_data(:,4), 'poly2');  % Curve Fitting Toolbox
    coefs = coeffvalues(mdl);                          % [a b c]

    % Overlay fit on left plot
    theta_dense = linspace(min(theta), max(theta), 400)';
    p_fit = feval(mdl, theta_dense);
    plot(hTheta, theta_dense, p_fit, 'r', 'LineWidth', 2);
    legend(hTheta, 'data', sprintf('poly2 fit  RMSE = %.3f mW', ...
        rms(raw_data(:,4) - feval(mdl, raw_data(:,2)))), 'Location','NorthWest');

    % Key angles
    theta_min = -coefs(2)/(2*coefs(1));
    min_power = feval(mdl, theta_min);
    target_max_power = 25;  % mW (adjust for your lab)
    roots_ = roots([coefs(1), coefs(2), coefs(3) - target_max_power]);
    theta_max = max(roots_(isreal(roots_)));
    real_max_power = feval(mdl, theta_max);

    % Linear PDA calibration: mW ≈ diodeFactor * Volts
    diodeFactor = raw_data(:,3) \ raw_data(:,4);   % slope-only fit
    v_line = linspace(min(raw_data(:,3)), max(raw_data(:,3)), 100)';
    plot(hDiode, v_line, diodeFactor * v_line, 'r', 'LineWidth', 2);
    legend(hDiode, 'data', sprintf('linear fit  RMSE = %.3f mW', ...
        rms(raw_data(:,4) - diodeFactor * raw_data(:,3))), 'Location','NorthWest');

    % Package results
    powerCalibrationData(wct).lambda      = lambda;        %#ok<AGROW>
    powerCalibrationData(wct).raw_data    = raw_data;      %#ok<AGROW>
    powerCalibrationData(wct).mdl         = mdl;           %#ok<AGROW>
    powerCalibrationData(wct).coefs       = coefs;         %#ok<AGROW>
    powerCalibrationData(wct).theta_min   = theta_min;     %#ok<AGROW>
    powerCalibrationData(wct).min_power   = min_power;     %#ok<AGROW>
    powerCalibrationData(wct).theta_max   = theta_max;     %#ok<AGROW>
    powerCalibrationData(wct).max_power   = real_max_power;%#ok<AGROW>
    powerCalibrationData(wct).diodeFactor = diodeFactor;   %#ok<AGROW>

    if numel(wavelengths) > 1
        pause(0.5);
        [hTheta, hDiode] = render_fig(hFig, theta_range);
    end
end

% -------- save calibration --------
savePath = 'C:\Users\debivort lab\Documents\MATLAB\laser_power_control\powerCalibrationData_newsetup2025.mat';
try
    save(savePath, 'powerCalibrationData');
    fprintf('Saved calibration to:\n  %s\n', savePath);
catch ME
    warning('Could not save calibration file:\n%s', getReport(ME,'basic','hyperlinks','off'));
end

% -------- optionally close the PM100D --------
try, fclose(PM100D); catch, end
disp('Calibration complete.');
end % ====== end main function ======


%% ====== helpers (serialport-safe; no laser_control) ======
function state = isReady_serialport(sp)
writeline(sp,'1TS');
resp = tryRead(sp);
if ~ischar(resp), resp = char(resp); end
m = regexp(resp,'1TS[0-9A-Fa-f]{4}([0-9A-Fa-f]{2})','tokens','once');
if isempty(m)
    state = false;
else
    stateByte = upper(m{1});
    state = any(strcmp(stateByte, {'32','33','34','35'}));
end
end

function r = tryRead(sp)
r = '';
try
    r = readline(sp);
catch
    r = '';
end
end

function [hTheta, hDiode] = render_fig(hFig, theta_range)
clf(hFig);
hTheta = subplot(1,2,1,'Parent',hFig);
axis(hTheta,'square'); grid(hTheta,'on'); hold(hTheta,'on');
xlabel(hTheta,'Theta (deg)'); ylabel(hTheta,'Objective Power (mW)');
xlim(hTheta, theta_range);

hDiode = subplot(1,2,2,'Parent',hFig);
axis(hDiode,'square'); grid(hDiode,'on'); hold(hDiode,'on');
xlabel(hDiode,'Photodiode (V)'); ylabel(hDiode,'Objective Power (mW)');
end
