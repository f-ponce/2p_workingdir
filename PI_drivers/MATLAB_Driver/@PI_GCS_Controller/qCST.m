function [szAnswer] = qCST(c,szAxes)
%   DESCRIPTION
%   Get the type names of the positioners associated with szAxes. The individual names are preceded by the 
%   one-character axis identifier followed by ”=” the positioner name and a “\n” (line-feed). The line-feed is 
%   preceded by a space on every line except the last. 
%
%   SYNTAX
%       [szAnswer] = PIdevice.qCST(szAxes)
% 
%   INPUT
%       szAxes (char array)         identifiers of the axes, if '' or no parameters were passed, all axes are affected
%
%   OUTPUT
%       [szAnswer] (char array)     buffer to receive the string read in from controller,
%                                   lines are separated by '\n' ("line-feed") 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	szAnswer = blanks(1001);
	if(~exist('szAxes'))
		szAxes = '';
	end
	try
		[bRet,szAxes,szAnswer] = calllib(c.libalias,functionName,c.ID,szAxes,szAnswer,1000);
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
