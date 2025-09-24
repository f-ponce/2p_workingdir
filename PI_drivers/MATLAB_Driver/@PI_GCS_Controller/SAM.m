function SAM(c,axisContainerUnit,axisOperationMode)
%   DESCRIPTION
%   
%   Sets the operating mode of the axis.
%   
%
%   SYNTAX
%        PIdevice.SAM(axisContainerUnit,axisOperationMode)
% 
%   INPUT
%       axisContainerUnit (char array)           One axis of the control
%
%       axisOperationMode (int array)            Operating mode of the axis
% 
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end
axisContainerUnit = ConvertCellArrayStringToString (axisContainerUnit);
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,axisContainerUnit,axisOperationMode);
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