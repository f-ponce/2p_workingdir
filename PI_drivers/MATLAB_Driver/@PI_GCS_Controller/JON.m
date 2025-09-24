function JON(c,iJoystickIDs,iValues)
%   DESCRIPTION
%   Enable or disable a joystick which is directly connected to the controller.
%   The joystick must be enabled for joystick control of the controller axis 
%   which was assigned to the joystick axis with JAX().
%   See "Joystick Control" in the controller User Manual for details.
%
%   SYNTAX
%       PIdevice.JON(iJoystickIDs,iValues)
% 
%   INPUT
%       iJoystickIDs (int array)            array with joystick devices connected to the controller 
%
%       iValues (int array)                 pointer to array with joystick enable states
%                                           (0 for deactivate, 1 for activate)
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piJoystickIDs = libpointer('int32Ptr',iJoystickIDs);
	piValues = libpointer('int32Ptr',iValues);
	nValues = length(iJoystickIDs);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,piJoystickIDs,piValues,nValues);
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
