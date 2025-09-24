function RES(c,axisContainerUnit)
%   DESCRIPTION
%
%   Deletes the error bit (bit 0) in the status register of the axis and transfers
%   the axis from the "Fault" state to the "Ready to switch on" state.
%   
%
%   SYNTAX
%       PIdevice.RES(axisContainerUnit)
% 
%   INPUT
%       axisContainerUnit (char array)               One axis of the control
%     
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if(c.ID<0), error('The controller is not connected'),end;
axisContainerUnit = ConvertCellArrayStringToString (axisContainerUnit);
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,axisContainerUnit);
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