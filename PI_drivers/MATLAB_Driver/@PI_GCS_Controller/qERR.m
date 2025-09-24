function [iVal] = qERR(c)
%   DESCRIPTION
%   Get the error state of the controller. Because the DLL may have queried (and cleared) controller error 
%   conditions on its own, it is safer to call GetError() which will first check the internal error state of the 
%   library. For a list of possible error codes see p. 136.
%
%   SYNTAX
%       [iVal] = PIdevice.qERR()
%
%   OUTPUT
%       [iVal] (int)        integer to receive error code of the controller 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	iVal = 1;
	piValue = libpointer('int32Ptr',iVal);
	try
		[bRet,iVal] = calllib(c.libalias,functionName,c.ID,piValue);
		if(bRet==0)
			iError = GetError(c);
			szDesc = TranslateError(c,iError);
			error(szDesc);
		end
	catch
		rethrow(lasterror);
	end
else
	error('%s not found',functionName);
end
