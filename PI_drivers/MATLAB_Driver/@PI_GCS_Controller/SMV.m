function SMV(c,axisContainerUnits,numberOfSteps)
%   DESCRIPTION
%
%   Sets the number and direction of the steps to be taken for the specified axes and starts executing the steps.
%   All axes specified in the command start the movement at the same time.
%   
%
%   SYNTAX
%       PIdevice.SMV(axisContainerUnits,numberOfSteps)
% 
%   INPUT
%       axisContainerUnits (char array)         One axis of the control
%
%       numberOfSteps (int array)               Number and direction of the steps to be taken
%     
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if(c.ID<0), error('The controller is not connected'),end;
axisContainerUnits = ConvertCellArrayStringToString (axisContainerUnits);
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,axisContainerUnits,numberOfSteps);
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