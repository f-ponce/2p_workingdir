function MEX(c,szCondition)
%   DESCRIPTION
%   Stop macro execution due to a given condition of the following type: a specified value is compared with a 
%   queried value according to a specified rule. Can only be used in macros.
%   When the macro interpreter accesses this command the condition is checked. If it is true the current macro 
%   is stopped, otherwise macro execution is continued with the next line. Should the condition be fulfilled 
%   later, the interpreter will ignore it. See also WAC().
%   See "Controller Macros" and the MEX command description in the controller User Manual for details.
%
%   SYNTAX
%       PIdevice.MEX(szCondition)
% 
%   INPUT
%       szCondition (char array)            string with condition to evaluate
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,szCondition);
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
