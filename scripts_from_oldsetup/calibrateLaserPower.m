function calibrateLaserPower(theta_range, step_size, wavelengths)
% Automated routine for calibrating laser power. Maps objective power in mW
% to photodiode reading on the table and half-wave plate angle provided to
% PR50CC powerController object
% 
% ARGUMENTS:
%           theta_range     vector with min and max half-wave plate angles:
%                           [theta_min, theta_max]
%           default = [158, 166]
%
%           step_size       size of theta steps, in degrees
%           default = 0.05
%
%           wavelengths     integer vector of wavelengths (nm) to calibrate
%           default = 930
%
% OUTPUTS:
%           powerCalibrationData_CURRENT.mat    calibration data file
%           saved to 'C:\Users\Matthew Churgin\Documents\2pcomp\scanimage_dbl\'

if nargin == 3
    if any(wavelengths > 1000) || any(wavelengths < 730)
        error('Requested wavelengths out of acceptable MaiTai range')
    end
end

if nargin < 3
    wavelengths = 930;
end

if nargin < 2
    step_size = 0.05;
end

if nargin < 1
    theta_range =  [162 168];
end


AI_CHANNEL = 0; % Analog input channel on USB-6001 (Dev2) acquiring 
%                 photodiode signal

% Define each step for theta
theta = theta_range(1):step_size:theta_range(2);

global USB6001 USB6001AnalogInputs PM100D powerController

try
    if isempty(USB6001AnalogInputs)
        display('Connecting to USB-6001...')
        USB6001 = connectToUSB6001(AI_CHANNEL);
    end
catch
    error('Could not connect to USB-6001 device.  Try restarting MATLAB and then try again.')
end


if isempty(PM100D)
    display('Connecting to ThorLabs PM100D power meter via USB...')
    
    try
        connectToPM100D
    catch
        error('Unable to connect to PM100D power meter.  Make sure that meter is connected via USB and turned on, then try again.')
    end
    
elseif ~strcmp(PM100D.Status,'open')
    fopen(PM100D);

end


if isempty(powerController)
    connectToPowerController(1);
else
	if ~strcmp(powerController.Status,'open')
        fopen(powerController);
        pause(1)
    end
end


% Flush the data in the PM100D input buffer.
flushinput(PM100D);
pause(1)

% Make sure meter is in 'POWER' measurement mode and auto-ranging
fprintf(PM100D, 'CONF:POW');
fprintf(PM100D, 'CURR:RANG:AUTO %d', 1);
pause(2)

% Ready laser
if ~laser_control('ISPULSING?')
    error('Calibration failed.  Laser must be pulsing to run calibration.  Wait until laser is modelocked, then try again.')
end


% Make sure the user is ready for running calibration
hFig = figure('Color','w','Position',[215,175,1475,710]);
[hTheta, hDiode] = render_fig(hFig,theta_range);

% Modal continue box...
hWarn = warndlg(sprintf('Calibration is about to begin.  The MaiTai must be running and modelocked to continue. \n\nMake sure that you have positioned the power sensor as close as possible to the objective and closed the curtain. \n\nManually open the hard shutter now by selecting ''Local'' and ''N.O.'' on the front panel of the shutter driver  (note: emission remains blocked by MaiTai shutter until calibration begins) \n\nIt is recommended that you let the laser warm up for at least 30 minutes after modelocking to ensure power stability.  \n\nOnce you are ready, press OK to continue...\n\n\n'), 'POWER CALIBRATION TOOL');
waitfor(hWarn);
display('Beginning calibration...')


% Zero sensor readings
fprintf(PM100D, 'CORR:COLL:ZERO:INIT');
pause(2)


try
	laser_control('OPENSHUTTER')
catch
	error('Failed to open MaiTai shutter. Confirm MaiTai is modelocked and try again.')
end




%%%% ----- Begin calibration loop ----- %%%
% Catch errors in this block to make sure soft shutter gets closed
% try
    
    wct = 0;
    
    for lambda = sort(wavelengths)
        
        wct = wct + 1;
        
        % Set correction wavelength
        fprintf(PM100D, sprintf('CORR:WAV %d',lambda));
        
        % Update figure title
        title(hTheta,sprintf('Objective power plot \nwavelength = %d nm',lambda))
        title(hDiode,sprintf('Photodiode sensor plot \nwavelength = %d nm',lambda))
        
        if laser_control('WAVELENGTH?') ~= lambda
            laser_control('SETWAVELENGTH',lambda)
        end
        
        ct = 0;
        
        for i = 1:length(theta)
            
            ct = ct + 1
            
            fprintf(powerController, sprintf('1PA%3.3f', theta(i)));
            pause(0.1)
            
            % Make sure things have settled
            while ~isReady(powerController,lambda)
                pause(0.1)
            end
            
            AIdata = USB6001AnalogInputs.inputSingleScan;
            fprintf(PM100D, 'READ?');
            
            raw_data(ct,:) = [lambda, theta(i), AIdata(AI_CHANNEL+1), 1e3*str2num(fscanf(PM100D))];
            % i.e. [lambda, theta, photodiodeVoltage, ObjectivePower_mW]
            
            % Update plot
            hPtTheta = plot(hTheta,raw_data(ct,2),raw_data(ct,4),'o');
            %hPtDiode = plot(hDiode,raw_data(ct,3),raw_data(ct,4),'o');]
            hPtDiode = plot(hDiode,raw_data(ct,2),raw_data(ct,3),'o');
            drawnow
        end
        
        
        % Fit a second-order polynomial to the (theta, power@obective) curve
        mdl = fit(raw_data(:,2),raw_data(:,4),'poly2');
        
        hPtTheta(2) = plot(hTheta,raw_data(:,2),feval(mdl,raw_data(:,2)),'r','LineWidth',2);
        legend(hPtTheta,'data',sprintf('polynomial fit \nRMSE = %0.3f mW', ...
            rms(raw_data(:,4)-feval(mdl,raw_data(:,2)))),'Location','Northwest');
        
        coefs = coeffvalues(mdl);
        
        % --- Now, we'll create the mapping from desired power (mW) to half-wave plate rotation angle (theta) --- %
        
        % Calculate the value of theta that produced minimum power
        theta_min = -coefs(2)/(2*coefs(1));
        min_power = feval(mdl,theta_min);
        
        % Calculate the theta value that produces the maximum desired power (e.g. 20mW)
        target_max_power = 25; %(mW)
        theta_max = max(roots([coefs(1),coefs(2),coefs(3)-target_max_power]));
        real_max_power = feval(mdl,theta_max);
        
        
        % Scaling factor mapping photodiode reading (V) to objective power (mW)
        %   Within 0-50mW, the relationship is linear and the measured offset is
        %   essentially zero, so intercept term is unnecessary.
        diodeFactor = raw_data(:,3)\raw_data(:,4);
        
        hPtDiode(2) = plot(raw_data(:,3),diodeFactor*raw_data(:,3),'r','LineWidth',2);
        drawnow
        
        legend(hPtDiode,'data',sprintf('linear fit \nRMSE = %0.3f mW', ...
            rms(raw_data(:,4)-diodeFactor*raw_data(:,3))),'Location','Northwest');
        
        % Store data in a structure, indexed by wavelengths
        powerCalibrationData(wct).lambda = lambda;
        powerCalibrationData(wct).raw_data = raw_data;
        powerCalibrationData(wct).mdl = mdl;
        powerCalibrationData(wct).coefs = coefs;
        powerCalibrationData(wct).theta_min = theta_min;
        powerCalibrationData(wct).min_power = min_power;
        powerCalibrationData(wct).theta_max = theta_max;
        powerCalibrationData(wct).max_power = real_max_power;
        powerCalibrationData(wct).diodeFactor = diodeFactor;
        
        
        if length(wavelengths) > 1
            
            pause(5)
            
            [hTheta, hDiode] = render_fig(hFig,theta_range);
            
            raw_data = [];
        end
        
    end
    
% catch
%     laser_control('CLOSESHUTTER')
%     error('There was a problem with the calibration.  Check that the devices are properly connected and try again.')
% end


laser_control('CLOSESHUTTER')



% Save calibration file to default location
save('C:\Users\Matthew Churgin\Documents\2pcomp\scanimage_dbl\powerCalibrationData_CURRENT', 'powerCalibrationData')


% Disconnect from PM100D Power Meter
fclose(PM100D);
display('Calibration complete!  Make sure to switch the shutter driver back to REMOTE and N.C. before imaging!')


%%% --- Helper functions --- %%%
function state = isReady(powerController,lambda)
% Check whether MaiTai wavelength has settled and PR50CC controller is
% ready to accept movement commands

fprintf(powerController, '1TS');
s = fscanf(powerController);
state = any(strcmp(s(8:9), {'32', '33', '34', '35'})) && (laser_control('WAVELENGTH?') == lambda);
% Status codes 32:35 indicate the stage is ready to accept movement commands


function [hTheta, hDiode] = render_fig(hFig,theta_range)

% Activate chosen figure
clf(hFig)

% Set up axes
hTheta = subplot(1,2,1);
axis square
grid on
xlabel('Theta (deg)')
ylabel('Objective Power (mW)')
xlim(theta_range)
%ylim([0 30])
%set(hTheta,'YTick',0:2:30)
hold on

hDiode = subplot(1,2,2);
axis square
grid on
%xlabel('Photodiode reading (V)')
%ylabel('Objective Power (mW)')
xlabel('Theta (deg)')
ylabel('Photodiode reading (V)')
%xlim([0 5])
%ylim([0 30])
%set(hDiode,'YTick',0:2:30)
hold on
