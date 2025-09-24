function RemoveStage(c,szAxes)
%   DESCRIPTION
%   Removes the positioner with the given name from the PI_UserStages2.dat 
%   file which contains user-defined positioners. 
%
%   SYNTAX
%       PIdevice.RemoveStage(szAxes)
% 
%   INPUT
%       szAxes (char array)             the positioner name as string. 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
