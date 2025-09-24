function [iRet] = IsConnected(c)
%   DESCRIPTION
%   Checks if PIdevice is connected
%
%   SYNTAX
%       [iRet] = Pidevice.IsConnected
%
%   OUTPUT
%       [iRet] (int)                0 if PIdevice is not connected
%                                   1 if PIdevice is connected
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
