function [iVal] = qCCL(c)
%   DESCRIPTION
%   Returns the current CommandLevel. 
%
%   SYNTAX
%       [iVal] = PIdevice.qCCL()
%
%   OUTPUT
%       [iVal] (int)            variable to receive the current command level.
%                               See CCL() for possible values.
%    
%   PI MATLAB Class Library Version 1.5.0  
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
