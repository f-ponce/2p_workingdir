function varargout = laser_control(cmdStr,value)
%LASER_CONTROL   function for interfacing with MaiTai laser
%
%   out = laser_control(cmdStr, value[optional])
%
%   INPUTS
%
%   'cmdStr' may take any of the following values:
%   'ON'            - Turn laser on. Must be fully warmed up with key enabled. Closes shutter, if open.
%   'OFF'           - Turn laser off and close shutter, if open.
%   'OPENSHUTTER'   - Open shutter on MaiTai. Must be ON and modelocked.
%   'CLOSESHUTTER'  - Close shutter on MaiTai.
%   'SETWAVELENGTH' - Set wavelength tuning to 'VALUE' argument (nm)
%   'DISCONNECT'    - Sever serial connection with MaiTai
%   'ISPULSING?'    - Returns state of MaiTai pulsing/modelocked (0=OFF,1=ON)
%   'SHUTTEROPEN?'  - Returns state (0=CLOSED,1=OPEN) of the MaiTai shutter.
%   'WAVELENGTH?'	- Returns current wavelength tuning (nm)
%   'POWER?'        - Returns current IR power (Watts)
%   'HISTORY?'      - Returns a 1x16 vector containing 16 most recent status codes
%   'STATUS?'       - Returns integer indicating current MaiTai status:
%                     120 = DISABLED
%                     116 = OFF/ENABLED
%                       5 = OFF/ENABLED
%                       3 = ON/CW(not modelocked)
%                       1 = ON/PULSING(modelocked)
%                   OTHER = ERROR CONDITION (see Appendix C in MaiTai User's Manual)
%
%   VALUE is numerical argument specifying wavelength (in nm) for
%   SETWAVELENGTH command.
%
%   OUTPUTS
%
%   OUT - output value for queries. No output returns empty set.
%
%   Kyle Honegger (Harvard) - February 2016
warning off backtrace

out = [];
timeout = 120; % number of seconds to wait for laser to warm up before
% exiting with error

global maiTai


% Establish serial comm, if necessary
if isempty(maiTai)
    maiTai = connectToMaiTai;
end

fprintf(maiTai,'PLAS:AHIS?')
status = str2double(strsplit(fscanf(maiTai)));

% Handle command strings
if strcmpi(cmdStr,'ON')
    % 2021-06-17
    % Update de Bivort lab website monitor status to in use (green)
    try
        [~,status]=urlread('http://lab.debivort.org/mu.php?id=2photon&st=1');
    catch
        disp('unable to connect to http://lab.debivort.org');
    end   
    
    % Close shutter, if open already
    fprintf(maiTai,'SHUT?')
    if fscanf(maiTai) == 1
        fprintf(maiTai,'SHUT 0')
    end
    
    
    %%%% Make sure laser can be turned on %%%%
    
    % Check that enable key is turned
    if status(1) == 120
        error('MaiTai is currently disabled. Turn interlock key to enable.')
        return
    end
    
    % Check that laser isn't already turned on
    if status(1) < 5  % codes <5 indicate active lasing
        error('MaiTai is already lasing.')
        return
    end
    
    % Check that laser is warmed up
    fprintf(maiTai,'READ:PCTW?')
    warmed_up = str2num(fscanf(maiTai));
    
    if warmed_up == 100
        fprintf(maiTai,'ON')
        %if ~maiTai.UserData, try urlread('http://lab.debivort.org/mu.php?id=2photon&st=1'); end; end
    else
        warning('Waiting for laser to warm up')
        tic
        while toc < timeout
            fprintf(maiTai,'READ:PCTW?')
            warmed_up = str2num(fscanf(maiTai));
            
            if warmed_up == 100
                fprintf(maiTai,'ON')
                
            end
        end
        
        error('Timed out waiting for laser to warm up')
        
    end
    
elseif  strcmpi(cmdStr,'OFF')
    % 2021-06-17
    % Update de Bivort lab website monitor status to idle (yellow)
    try
        [~,status]=urlread('http://lab.debivort.org/mu.php?id=2photon&st=2');
    catch
        disp('unable to connect to http://lab.debivort.org');
    end   
    
    % Check to see whether laser is running
    if status(1) < 5    
        % Turn off pump laser and close shutter
        fprintf(maiTai,'OFF')
        fprintf(maiTai,'SHUT 0')
        if ~maiTai.UserData, try urlread('http://lab.debivort.org/mu.php?id=2photon&st=2'); end; end
    else
        error('Laser is not running.')
    end
    
elseif strcmpi(cmdStr,'OPENSHUTTER')
    % Check whether laser is modelocked
    if status(1) == 1
        fprintf(maiTai,'SHUT 1')
    else
        error('Laser is not modelocked.  MaiTai must be in pulsing mode to open shutter.')
    end
    
elseif strcmpi(cmdStr,'CLOSESHUTTER')
    fprintf(maiTai,'SHUT 0')
    
elseif strcmpi(cmdStr,'SETWAVELENGTH')
    % Check if value argument was set
    if nargin < 2, error('Please specify desired wavelength.'); end
    
    % Check if requested wavelength is within acceptable range (730-1000nm)
    if value >= 730 && value <= 1000
        fprintf(maiTai,['WAV ' sprintf('%d',value)])
        display(sprintf('Changing wavelength to %dnm',value))
        pause(2)
    else
        error('Wavelength is outside acceptable range. Please enter a value between 700 and 1000nm')
    end
    
elseif strcmpi(cmdStr,'DISCONNECT')
    try
        disconnectMaiTai(maiTai)
        clear global maiTai
        display('MaiTai was successfully disconnected.')
    catch err
        rethrow(err)
    end
    
elseif strcmpi(cmdStr,'ISPULSING?')
    out = logical(status(1) == 1);
    
elseif strcmpi(cmdStr,'SHUTTEROPEN?')
    fprintf(maiTai,'SHUT?')
    out = logical(str2num(fscanf(maiTai)));
    
elseif strcmpi(cmdStr,'WAVELENGTH?')
    fprintf(maiTai,'READ:WAV?')
    out = fscanf(maiTai);
    out = str2num(out(1:3));
    
elseif strcmpi(cmdStr,'POWER?')
    fprintf(maiTai,'READ:POW?')
    out = fscanf(maiTai);
    out = str2num(out(1:6));
    
elseif strcmpi(cmdStr,'HISTORY?')
    fprintf(maiTai,'PLAS:AHIS?')
    out = str2double(strsplit(fscanf(maiTai)));
    
elseif strcmpi(cmdStr,'STATUS?')
    out = status(1);
    
else
    error('Unrecognized MaiTai command')
end


if nargout > 0, varargout{1} = out; end

warning on backtrace
