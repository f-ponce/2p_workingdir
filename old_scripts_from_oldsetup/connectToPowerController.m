function connectToPowerController(verbose)

if nargin < 1
    verbose = 0;
end


% Make sure MaiTai is shuttered before running startup routine.  Could be
% dangerous to run the limit check, otherwise!
if laser_control('SHUTTEROPEN?')
    display('Shutter is open!  Closing it now prior to initializing...')
    laser_control('CLOSESHUTTER');
end


if verbose
    display('Connecting to PR50CC power controller...')
end

global powerController

try
    if isempty(powerController)
        powerController = serial('COM3','BaudRate',57600,'FlowControl','software','Terminator','CR/LF');
    end
    
    flushinput(powerController);
    
    if ~strcmp(powerController.Status,'open')
        fopen(powerController);
        pause(1)
    end
    
    if ~isReady(powerController) % handle condition where controller is 
                                 % already initialized and running
        
        % Configure controller with pre-loaded params
        fprintf(powerController, '1PW1')
        pause(1)
        fprintf(powerController, '1ZX2')
        pause(2)
        fprintf(powerController, '1PW0')
        pause(2)
        
        
        % Flush status buffer on controller
        fprintf(powerController, '1TS');
        fscanf(powerController);
        
        fprintf(powerController, '1TS');
        fscanf(powerController);
        
        
        % HOME controller to begin (required)
        if verbose
            display('Finding power controller limits.  This might take a minute...')
        end
        
        fprintf(powerController, '1OR');
        
        while ~isReady(powerController)
            pause(0.01)
        end
        
        
        % Initialize motor
        fprintf(powerController, '1MM1');
        pause(0.5)
        
    end
    
    % Command move to hard coded home position and make sure it gets there
    if verbose
        display('Setting laser power to minimum...')
    end
    
    try
        load('C:\Users\Microscope Lab\Documents\scanimage_dbl\powerCalibrationData_CURRENT.mat');
        home_position = powerCalibrationData.theta_min;
    catch
        home_position = 158.13;
    end
    
    fprintf(powerController, sprintf('1PA%3.3f', home_position));
    
    pause(1)
    while ~isReady(powerController)
        pause(0.01)
    end
    
    
    % Read current position
    fprintf(powerController, '1TP');
    position_current = fscanf(powerController);
    position_current = str2double(position_current(4:end));
    
    if abs(position_current - home_position) < 2
        if verbose
            display('PR50CC power controller connected.')
        end
    else
        warning off backtrace
        warning('There seems to be a problem connecting to the PR50CC power controller.')
        warning on backtrace
    end
    
catch
    error('Cannot connect to the PR50CC power controller. Make sure the rack power is turned on, or try restarting MATLAB.')
end



%%% - Helper functions - %%%
function state = isReady(powerController)
% Check whether controller is ready to accept movement commands

fprintf(powerController, '1TS');
s = fscanf(powerController);
state = any(strcmp(s(8:9), {'32', '33', '34', '35'}));
% Status codes 32:35 indicate the stage is ready to accept movement commands

