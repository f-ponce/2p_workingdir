function [maiTai,status] = connectToMaiTai
%function [maiTai,status] = connectToMaiTai
%
%   Establish serial communications with MaiTai laser. Returns
%   a serial object for controlling the laser, as well as a
%   vector of the 16 most recent status codes.

global maiTai

display('Connecting to MaiTai...')

try
    maiTai = serial('COM9','FlowControl','software');
    fopen(maiTai);
    
    fprintf(maiTai,'PLAS:AHIS?')
    status = str2double(strsplit(fscanf(maiTai)));
    
    % Check status and humidity and raise warnings
    warning off backtrace
    
    if status(1) == 120
        warning('MaiTai is currently in standby. Turn interlock key to enable.')
    end
    
    
    fprintf(maiTai,'READ:HUM?')
    hum = str2double(strsplit(fscanf(maiTai)));
    
	if hum(1) > 9
        warning(['Laser cavity humidity is >9% RH.  This may cause problems' ...
        'with modelocking.  Change purge filter soon (see Appendix D in MaiTai User Manual)!'])
        maiTai.UserData = 1; % Put laser in warning state (1)
        try urlread('http://lab.debivort.org/mu.php?id=2photon&st=3'); end
    else
        maiTai.UserData = 0; % Put laser in normal state (0)
    end
    
    warning on backtrace
    
    display('MaiTai connected.')
    
    
    % 2021-06-17
    % Update de Bivort lab website monitor status to idle (yellow)
    try
        [~,status]=urlread('http://lab.debivort.org/mu.php?id=2photon&st=2');
    catch
        disp('unable to connect to http://lab.debivort.org');
    end   
        
catch
    error('Cannot connect to MaiTai. Check that the laser is turned on, or try restarting MATLAB.')
end