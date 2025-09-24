function JLT(c,iJoystickID,iAxisID,iStartAddress,dValues)
%   DESCRIPTION
%   Fills the lookup table for the given axis of the given joystick device
%   which is connected to the controller.
%
%   SYNTAX
%       PIdevice.JLT(iJoystickID,iAxisID,iStartAddress,dValues)
% 
%   INPUT
%       iJoystickID (int)               joystick device connected to the controller
%
%       iAxisID (int)                   joystick axis to be set
%
%       iStartAddress (int)             index of a point in the lookup table, starts with 1
%
%       dValues (double array)          values of the points in the lookup table
%    
%   PI MATLAB Class Library Version 1.5.0  
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	pdValues = libpointer('doublePtr',dValues);
	nValues = length(dValues);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,iJoystickID,iAxisID,iStartAddress,pdValues,nValues);
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
