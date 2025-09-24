function [c, iNumDevices]  = OpenRS232DaisyChain ( c, iportNumber, iBaudRate )
%   DESCRIPTION
%   Open a RS-232 ("COM") interface to a daisy chain and set the baud rate of the daisy chain master. Note 
%   that calling this function does not open a daisy chain device—to get access to a daisy chain device you 
%   have to call ConnectDaisyChainDevice()! All future calls to ConnectDaisyChain() need the ID 
%   returned by OpenRS232DaisyChain(). 
%
%   SYNTAX
%       [controllerID, iNumDevices] = Controller.OpenRS232DaisyChain (iportNumber, iBaudRate)
% 
%   INPUT
%       iportNumber (int)                              COM port to use (e.g. 1 for "COM1")
%
%       iBaudRate (int)                                baud rate to use
%
%   OUTPUT
%       [controllerID] (PI_GCS_Controller object)      ID of new object,throws error if interface could not
%                                                      be opened or no controller is responding, or controller
%                                                      responds that it is already connected via RS232.
%  
%       [iNumDevices] (int)                            number of connected daisy chain devices
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functionName = ['PI_', mfilename];
if(any(strcmp(functionName, c.dllfunctions)))

    % Create variables for C interface
    iNumDevices = 0;
    piNumDevices = libpointer ( 'int32Ptr', iNumDevices );

    szDCDevices = blanks ( 10001 );

    try
        % call C interface
        [ c.DC_ID, iNumDevices, szDCDevices ]  = calllib ( c.libalias, functionName, iportNumber, iBaudRate, piNumDevices, szDCDevices, 10001);

        if ( c.DC_ID < 0 )
            iError = GetError ( c );
            szDesc = TranslateError ( c, iError );
            error ( szDesc );
        end

    catch ME
        error ( ME.message );
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