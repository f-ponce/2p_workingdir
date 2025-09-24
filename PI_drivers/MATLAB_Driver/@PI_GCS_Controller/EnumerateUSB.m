function [devices] = EnumerateUSB(c, szFilter)
%   DESCRIPTION
%   Lists the identification strings of all controllers available via USB interfaces. Using the mask, you can filter 
%   the results for certain text.
%
%   SYNTAX
%       PIdevice.EnumerateUSB()
%       PIdevice.EnumerateUSB(szFilter)
% 
%   INPUT
%       szFilter (char array)       only controllers whose descriptions match the filter are returned in the buffer
%                                   (e.g. a filter of “E-517” will only return the E-517 controllers, 
%                                   and not all PI controllers).
%
%   OUTPUT 
%       [devices] (cell array)      List of PI devices.   
% 
%   PI MATLAB Class Library Version 1.5.0     
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Settings


%% Function arguments handle
if nargin<2; szFilter=''; end

%% Check input parameters


%%  Program start

functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    szDevices = blanks(10001);
    try
        [bRet,szDevices] = calllib(c.libalias,functionName,szDevices,10000,szFilter);
        if (bRet==0)
            szDevices = '';% no devices found -> return empty string.
        end

        devices = regexp(szDevices, '\n', 'split');
        devices = devices';
        
        % Usually the last entry is empty
        if (isempty(devices{end}))
            devices(end,:) = [];
        end
        
    catch
        rethrow(lasterror);
    end
else
    error('%s not found',functionName);
end
