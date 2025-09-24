function c = PI_ConnectRS232ByDevName(c, deviceName, baudRate)
%   DESCRIPTION
%   Open an RS-232 interface to a controller with Linux. The call also sets
%   the baud rate on the controller side. All future calls to control this
%   controller need the ID returned by this call.
%
%   SYNTAX
%       [controllerID] = Controller.PI_ConnectRS232ByDevName(deviceName, baudRate)
%
%   INPUT
%       deviceName (char array)                        Portnumber, COM port to use (e.g. 1 for "COM1")
%
%       baudRate (int)                                 Baud rate to use
%
%   OUTPUT
%       [controllerID] (PI_GCS_Controller object)      ID of new object,throws error if interface could not
%                                                      be opened or no controller is responding, or controller
%                                                      responds that it is already connected via RS232.
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% only load dll if it wasn't loaded before
if(~libisloaded(c.libalias))
	c = LoadGCSDLL (c);
end
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[c.ID] = calllib(c.libalias, functionName, deviceName, baudRate);
		if(c.ID<0)
			iError = GetError(c);
			szDesc = TranslateError (c, iError);
			error(szDesc);
		end
    catch ME
        error (ME.message);
	end
else
	error('%s not found',functionName);
end
