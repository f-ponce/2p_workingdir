function c = TryConnectRS232(c,iPort,iBaudarte)
%   DESCRIPTION
%   Starts background thread which tries to establish connection to controller with given RS-232 settings.
%
%   SYNTAX
%       [controllerID] = Controller.TryConnectRS232(iPort,iBaudarte)
% 
%   INPUT
%       iPort (int)                                     COM port to use (e.g. 1 for "COM1")
%
%       iBaudarte (int)                                 baudrate to use
%
%   OUTPUT
%       [controllerID] (PI_GCS_Controller object)       ID of new thread (>=0), error code (<0) if there was an error
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% only load dll if it wasn't loaded before
if(~libisloaded(c.libalias))
	c = LoadGCSDLL(c);
end
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[c.ID] = calllib(c.libalias,functionName,iPort,iBaudarte);
		if (c.ID == -1)
			error ( 'Interface could not be opened or no controller is responding. Check if controller is switched on and properly connected.' );
		end
	catch
		rethrow(lasterror);
	end
else
	error('%s not found',functionName);
end
