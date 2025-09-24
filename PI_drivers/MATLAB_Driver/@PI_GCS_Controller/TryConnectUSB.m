function [c] = TryConnectUSB(c,szDescription)
%   DESCRIPTION
%   Starts background thread which tries to establish connection to controller with given USB settings.
%
%   SYNTAX
%       [controllerID] = Controller.TryConnectUSB(szDescription)
% 
%   INPUT
%       szDescription (char array)                      the description of the controller returned by EnumerateUSB
%
%   OUTPUT
%       [controllerID] (PI_GCS_Controller object)       ID of new thread (>=0), error code (<0) if there was an error
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[c.ID, ~] = calllib(c.libalias, functionName, szDescription);
		if (c.ID == -1)
			error ( 'Interface could not be opened or no controller is responding. Check if controller is switched on and properly connected.' );
		end
	catch
		rethrow ( lasterror );
	end
else
	error('%s not found',functionName);
end