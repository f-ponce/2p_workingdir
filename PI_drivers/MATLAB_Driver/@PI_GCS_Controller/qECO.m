function [szAnswer] = qECO(c,szAxes)
%   DESCRIPTION
%   Returns a string. qECO() can be used to test the communication.
%
%   SYNTAX
%       [szAnswer] = PIdevice.qECO(c,szAxes)
% 
%   INPUT
%       szAxes (char array)         array of any given combination of characters consisting of letters and numbers
%
%   OUTPUT
%       [szAnswer] (char array)     buffer to receive the string read in from controller
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
