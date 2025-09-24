function MAC_END(c)
%   DESCRIPTION
%   Take the DLL out of macro recording mode. This function resets a flag in the library and effects the 
%   operation of certain other functions. Function will fail if the DLL is not in recording mode. 
%   See "Controller Macros" and the MAC command description in the controller User Manual for details.
%
%   SYNTAX
%       PIdevice.MAC_END
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
