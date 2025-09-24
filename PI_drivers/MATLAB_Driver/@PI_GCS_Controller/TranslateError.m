function [szAnswer] = TranslateError(c,iErrorCode)
%   DESCRIPTION
%   Translate error number to error message. 
%
%   SYNTAX
%       [szAnswer] = PIdevice.TranslateError(iErrorCode)
% 
%   INPUT
%       iErrorCode (int)            number of error, as returned from GetError(). 
%
%   OUTPUT
%       [szAnswer] (char array)     buffer that will store the message 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	szAnswer = blanks(1001);
	try
		[bRet,szAnswer] = calllib(c.libalias,functionName,iErrorCode,szAnswer,1000);
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
