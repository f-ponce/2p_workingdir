function [szAnswer] = qVAR(c,szAxes)
%   DESCRIPTION
%   Gets variable value. If qVAR is combined with CPY(), JRC(), MEX() or WAC(), the response to qVAR() 
%   has to be a single value and not more. More information regarding local and global variables can be 
%   found in “Variables” in the controller User Manual.
%
%   SYNTAX
%       [szAnswer] = PIdevice.qVAR(szAxes)
% 
%   INPUT
%       szAxes (char array)         name of the variable to be queried
%
%   OUTPUT
%       [szAnswer] (char array)     is the value to which the variable is set
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
