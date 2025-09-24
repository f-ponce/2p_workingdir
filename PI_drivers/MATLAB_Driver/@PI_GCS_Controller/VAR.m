function VAR(c,sVariable,sValue)
%   DESCRIPTION
%   Sets a variable to a certain value.
%   Local variables can be set using VAR() in macros only.
%   The variable is present in RAM only.
%   See “Variables” and "Controller Macros" in the controller User Manual for details.
%
%   SYNTAX
%       PIdevice.VAR(sVariable,sValue)
% 
%   INPUT
%       sVariable (char array)          name of the variable whose value is to be set
%
%       sValue (char array)             is the value to which the variable is to be set.
%                                       If omitted, the variable is deleted. 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,sVariable,sValue);
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
