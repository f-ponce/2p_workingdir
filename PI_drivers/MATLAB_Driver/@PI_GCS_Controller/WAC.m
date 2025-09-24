function WAC(c,szAxes)
%   DESCRIPTION
%   Wait until a given condition of the following type occurs: a specified value is compared with a queried 
%   value according a specified rule. Can only be used in macros.
%   See also MEX(). See "Controller Macros" in the controller User Manual for details.
%   Valid for: E-861, C-867, C-887, C-863, C-884, E-871
%
%   SYNTAX
%       PIdevice.WAC(szAxes)
% 
%   INPUT
%       szAxes (char array)         string with condition to evaluate
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,szAxes);
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
