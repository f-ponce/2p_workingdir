function [errorLog] = qLOG(c,startIndex)
%   DESCRIPTION
%   
%   Queries the content of the controller's log memory.
%    
%
%   SYNTAX
%        [errorLog] = PIdevice.qLOG(startIndex)
% 
%   INPUT
%       startIndex (int)                           Limitation of the query to certain errors
%
%   OUTPUT
%       [errorLog] (char array)                    Memory for the answer
%      
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    errorLog =  blanks(10001);
	try
		[bRet,errorLog] = calllib(c.libalias,functionName,c.ID,startIndex,errorLog,10000);
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