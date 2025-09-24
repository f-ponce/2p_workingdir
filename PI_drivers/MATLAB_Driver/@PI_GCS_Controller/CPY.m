function CPY(c,szVariableName,szCommand)
%   DESCRIPTION
%   Copy a command response into a variable
%
%   SYNTAX
%       PIdevice.CPY(szVariableName, szCommand)
% 
%   INPUT
%       szVariableName (char array)         name of variable
%
%       szCommand (char array)              query command, the result is stored in the variable given
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,szVariableName,szCommand);
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
