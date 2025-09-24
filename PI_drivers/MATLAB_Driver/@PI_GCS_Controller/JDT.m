function JDT(c,iInJoystickIDs,iInAxisID,iInValues)
%   DESCRIPTION
%   Set default lookup table for the given joystick axis of the given joystick which is directly connected to the 
%   controller.
%   The current valid lookup table for the specified joystick axis is overwritten by the selection made with 
%   JDT().
%   See "Joystick Control" in the controller User Manual for details. 
%
%   SYNTAX
%       PIdevice.JDT(iInJoystickIDs,iInAxisID,iInValues)
% 
%   INPUT
%       iInJoystickIDs (int array)              array with joystick devices connected to the controller
%
%       iInAxisID (int array)                   array with joystick axis to be set 
%
%       iInValues (array)                       pointer to array with table types for the corresponding joystick axes,
%                                               valid table types are:
%                                               1 = linear
%                                               2 = parabolic
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piInJoystickIDs = libpointer('int32Ptr',iInJoystickIDs);
	piInAxisID = libpointer('int32Ptr',iInAxisID);
	piInValues = libpointer('int32Ptr',iInValues);
	nValues = length(iInValues);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,piInJoystickIDs,piInAxisID,piInValues,nValues);
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
