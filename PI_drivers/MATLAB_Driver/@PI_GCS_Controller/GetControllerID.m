function [ID] = GetControllerID(c,threadID)
%   DESCRIPTION
%   Get ID of connected controller for given thread ID.
%
%   SYNTAX
%       PIdevice.GetControllerID(threadID)
% 
%   INPUT
%       threadID (int)          Thread ID
%
%   OUTPUT
%       [ID] (int)              ID of new controller (>=0), error code (<0) if there was an error,
%                               no thread running, or thread has not finished yet
% 
%   PI MATLAB Class Library Version 1.5.0     
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[ID] = calllib(c.libalias,functionName,threadID);
	catch
		rethrow(lasterror);
	end
else
	error('%s not found',functionName);
end
