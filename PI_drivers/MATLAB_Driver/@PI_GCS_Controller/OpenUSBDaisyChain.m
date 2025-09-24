function [c, iNumDevices]  = OpenUSBDaisyChain(c,serialnumber)
%   DESCRIPTION
%   Open a USB interface to a daisy chain. Note that calling this function does not open a daisy chain 
%   device—to get access to a daisy chain device you have to call ConnectDaisyChainDevice()! All future 
%   calls to ConnectDaisyChain() need the ID returned by OpenUSBDaisyChain().
%
%   SYNTAX
%       [controllerID, iNumDevices]  = PIdevice.OpenUSBDaisyChain(serialnumber)
% 
%   INPUT
%       serialnumber (char array)       serial number. The description of the controller returned by EnumerateUSB()
%
%   OUTPUT
%       [controllerID] (PI_GCS_Controller object)      ID of new object,throws error if interface could not
%                                                      be opened or no controller is responding.
%  
%       [iNumDevices] (int)                            number of connected daisy chain devices       
%
%   PI MATLAB Class Library Version 1.5.0      
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functionName = ['PI_', mfilename];
if(any(strcmp(functionName, c.dllfunctions)))

    % Create variables for C interface
    iNumDevices = 0;
    piNumDevices = libpointer('int32Ptr',iNumDevices);
    szDCDevices = blanks(2001);
    try
        % call C interface
        % second returning argument would be "serialnumber" which is not needed. Hence is "~"
        [ c.DC_ID, ~, iNumDevices, szDCDevices]  = calllib(c.libalias,'PI_OpenUSBDaisyChain',serialnumber, piNumDevices,szDCDevices,2000);

        if (c.DC_ID<0)
            iError = GetError(c);
            szDesc = TranslateError(c,iError);
            error(szDesc);
        end

    catch
        rethrow(lasterror);
    end

    % Create list of available Daisy Chain Devices
    daisyChainDevicesAsCellArray = regexp(szDCDevices, '\n', 'split');

    for address = 1 : size ( daisyChainDevicesAsCellArray , 2)
        if ( ~isempty ( daisyChainDevicesAsCellArray {address} ) )
            c.ConnectedDaisyChainDevices{address} = [sprintf('%02d: ', address), daisyChainDevicesAsCellArray{address}];
        end
    end
else
    error('Method %s not found',functionName);
end    