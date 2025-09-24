function [iRet] = STP(c)
%   DESCRIPTION
%   Stops the motion of all axes instantaneously. Sets error code to 10. STP() also stops macros. 
%   After the axes are stopped, their target positions are set to their current positions.
%
%   SYNTAX
%       [iRet] = PIdevice.STP
%
%   OUTPUT
%       [iRet] (int)                    1 if successful, 0 otherwise
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
