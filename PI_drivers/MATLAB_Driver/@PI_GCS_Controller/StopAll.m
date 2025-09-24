function [iRet] = StopAll(c)
%   DESCRIPTION
%   Stops the motion of all axes instantaneously. Sets error code to 10. This function is identical in 
%   function to STP(), but only one character is sent via the interface. 
%
%   SYNTAX
%       [iRet] = PIdevice.StopAll
% 
%   OUTPUT
%       [iRet] (int)                    1 if successful, 0 otherwise
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[iRet] = calllib(c.libalias,functionName,c.ID);
	catch
		rethrow(lasterror);
	end
else
	error('%s not found',functionName);
end
