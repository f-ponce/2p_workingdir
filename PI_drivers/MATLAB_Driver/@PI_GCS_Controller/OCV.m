function OCV(c,axisContainerUnits,controlValue)
%   DESCRIPTION
%
%   Sets the open loop control values for axes.
%   All axes specified in the command start the movement at the same time.
%   
%
%   SYNTAX
%       PIdevice.OCV(axisContainerUnits,controlValue)
% 
%   INPUT
%       axisContainerUnits (char array)               One axis of the control
%
%       controlValue (int array)                      Open loop control value for the axis
%     
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if(c.ID<0), error('The controller is not connected'),end;
axisContainerUnits = ConvertCellArrayStringToString (axisContainerUnits);
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    controlValue = libpointer('doublePtr',controlValue);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,axisContainerUnits,controlValue);
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