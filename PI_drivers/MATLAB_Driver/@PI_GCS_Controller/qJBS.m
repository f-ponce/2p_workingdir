function [bJoystickButtons] = qJBS(c,iJoystickIDs,iJoystickAxesIDs)
%   DESCRIPTION
%   Get the current status of the given button of the given joystick device which is directly connected to the 
%   controller. See "Joystick Control" in the controller User Manual for details.
%
%   SYNTAX
%       [bJoystickButtons] = PIdevice.qJBS(iJoystickIDs,iJoystickAxesIDs)
% 
%   INPUT
%       iJoystickIDs (int array)            array with joystick devices connected to the controller
%
%       iJoystickAxesIDs (int array)        array with joystick buttons
%
%   OUTPUT
%       [bJoystickButtons] (int array)      array to receive the joystick button state, 
%                                           indicates if the joystick button is pressed; 
%                                           0 = not pressed, 1 = pressed
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	nValues = length(iJoystickIDs);
	bJoystickButtons = zeros(size(iJoystickIDs));
	piJoystickIDs = libpointer('int32Ptr',iJoystickIDs);
	piJoystickAxesIDs = libpointer('int32Ptr',iJoystickAxesIDs);
	pbJoystickButtons = libpointer('int32Ptr',bJoystickButtons);
	try
		[bRet,~,~,bJoystickButtons] = calllib(c.libalias,functionName,c.ID,piJoystickIDs,piJoystickAxesIDs,pbJoystickButtons,nValues);
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
