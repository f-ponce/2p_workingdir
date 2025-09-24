function c = ConnectDaisyChainDevice(c,iDeviceNumber)
%   DESCRIPTION
%   Open a daisy chain device. All future calls to control this device need the ID returned 
%   by this call. Note that before connecting a daisy chain device using the ConnectDaisyChainDevice()
%   function, the daisy chain port has to be opened using the OpenRS232DaisyChain() or the 
%   OpenUSBDaisyChain() function, whichever is the appropriate one. After the daisy chain port has 
%   been opened all controllers connected to this daisy chain port can be "opened" using 
%   ConnectDaisyChainDevice(). A connection to a daisy chain device is closed using the 
%   CloseConnection() function. To close the daisy chain port the CloseDaisyChain() function has 
%   to be called. Closing the daisy chain port automatically closes all still opened daisy chain devices.
%
%   SYNTAX
%       [controllerID] = Controller.ConnectDaisyChainDevice(iDeviceNumber)
% 
%   INPUT
%       iDeviceNumber (int)                            the number of the daisy chain device to use, is a value between
%                                                      1  and  the iNumberOfConnectedDaisyChainDevices value of the 
%                                                      OpenRS232DaisyChain() function.
%
%   OUTPUT
%       [controllerID] (PI_GCS_Controller object)      ID of new object,throws error if interface could not
%                                                      be opened or no controller is responding.
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% only load dll if it wasn't loaded before
if(~libisloaded(c.libalias))
	c = LoadGCSDLL(c);
end
if(c.DC_ID < 0)
    error('DaisyChain not open');
end
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[c.ID] = calllib(c.libalias,functionName,c.DC_ID,iDeviceNumber);
		if (c.ID == -1)
			error ( 'Interface could not be opened or no controller is responding. Check if controller is switched on and properly connected.' );
        elseif (c.ID<-1)
			iError = GetError(c);
			szDesc = TranslateError(c,iError);
			error(szDesc);
		end
	catch
		rethrow(lasterror);
	end
else
	error('%s not found',functionName);
end
