function [iRet] = GetError(c)
%   DESCRIPTION
%   Get error status of the DLL and, if clear, that of the controller. If the library shows an error condition, its 
%   code is returned, if not, the controller error code is checked using PI_qERR() (p.136) and returned. After 
%   this call the DLL internal error state will be cleared; the controller error state will be cleared if it was 
%   queried.
%
%   SYNTAX
%       PIdevice.GetError
% 
%   OUTPUT
%       [iRet] (int)            error ID, see Error codes (see PIGCS-2-0-DLL manual SM151E) for the meaning of the codes. 
%
%   PI MATLAB Class Library Version 1.5.0    
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
