function ADD(c,szVariableName,value1,value2)
%   DESCRIPTION
%   Add two values and save the result to a variable.
%
%   SYNTAX
%       PIdevice.ADD(szVariableName,value1,value2)
% 
%   INPUT
%       szVariableName (char array)         name of variable to store the result
%
%       value1 (double)                     first value to be added
%
%       value2 (double)                     second value to be added
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,szVariableName,value1,value2);
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
