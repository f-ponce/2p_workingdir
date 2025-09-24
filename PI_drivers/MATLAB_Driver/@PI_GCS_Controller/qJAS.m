function [dValues] = qJAS(c,iJoystickIDsArray,iAxesIDsArray)
%   DESCRIPTION
%   Get the current status of the given axis of the given joystick device which is directly connected to the 
%   controller. The reported factor is applied to the velocity set with VEL() (closed-loop operation) or 
%   OVL() (open-loop operation), the range is -1.0 to 1.0.
%   See "Joystick Control" in the controller User Manual for details.
%
%   SYNTAX
%       [dValues] = PIdevice.qJAS(iJoystickIDsArray,iAxesIDsArray)
% 
%   INPUT
%       iJoystickIDsArray (int array)       array with joystick devices connected to the controller
%
%       iAxesIDsArray (int array)           array with joystick axes
%
%   OUTPUT
%       [dValues] (double array)            array to receive the joystick axis amplitude, i.e. the factor which is currently 
%                                           applied to the current valid velocity setting of the controlled motion axis; 
%                                           corresponds to the current displacement of the joystick axis. iArraySize  size of arrays
%                                           
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piJoystickIDsArray = libpointer('int32Ptr',iJoystickIDsArray);
	piAxesIDsArray = libpointer('int32Ptr',iAxesIDsArray);
	nValues = length(iJoystickIDsArray);
	dValues = zeros(size(iJoystickIDsArray));
	pdValues = libpointer('doublePtr',dValues);
	try
		[bRet,~,~,dValues] = calllib(c.libalias,functionName,c.ID,piJoystickIDsArray,piAxesIDsArray,pdValues,nValues);
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
