function [szAnswer] = qPUN(c,szAxes)
%   DESCRIPTION
%   Get the position units of szAxes.
%
%   SYNTAX
%       [szAnswer] = PIdevice.qPUN(szAxes)
% 
%   INPUT
%       szAxes (char array)         string with axes, if '' or no parameters were passed, all axes are affected
%
%   OUTPUT
%       [szAnswer] (char array)     array to receive the position units of the axes 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	szAnswer = blanks(1001);
	if(~exist('szAxes'))
		szAxes = '';
	end
	try
		[bRet,~,szAnswer] = calllib(c.libalias,functionName,c.ID,szAxes,szAnswer,1000);
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
