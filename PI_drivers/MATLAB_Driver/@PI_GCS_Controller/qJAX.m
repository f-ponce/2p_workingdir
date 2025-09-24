function [szAxes] = qJAX(c,iJoystickIDs,iJoystickAxesIDs)
%   DESCRIPTION
%   Get axis controlled by a joystick axis of a joystick device which is directly connected to the controller.
%   See "Joystick Control" in the controller User Manual for details.
%
%   SYNTAX
%       [szAxes] = PIdevice.qJAX(iJoystickIDs,iJoystickAxesIDs)
% 
%   INPUT
%       iJoystickIDs (int array)        array with joystick devices connected to the controller
%
%       iJoystickAxesIDs (int array)    array with IDs of the joystick axes
%
%   OUTPUT
%       [szAxes] (char array)           buffer to receive the string read in from controller;
%                                       will contain axis IDs of axes associated with corresponding joystick axis
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piJoystickIDs = libpointer('int32Ptr',iJoystickIDs);
	piJoystickAxesIDs = libpointer('int32Ptr',iJoystickAxesIDs);
	szAxes = blanks(2049);
	nValues = length(iJoystickIDs);
	try
		[bRet,~,~,szAxes] = calllib(c.libalias,functionName,c.ID,piJoystickIDs,piJoystickAxesIDs,nValues,szAxes,2048);
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
