function [iRet] = STF(c)
%   DESCRIPTION
%	Stops all axes abruptly (i.e. with maximum possible deceleration)
%	and terminates certain internal processes. Stopping transfers the axes
%	from the ‘Operation enabled’ state via the ‘Fault reaction active’ state to the ‘Fault’ state.
%
%   SYNTAX
%       [iRet] = PIdevice.STF
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
