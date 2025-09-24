function JAX(c,iJoyID,iJoyAxesID,sAxisNames)
%   DESCRIPTION
%   Set axis controlled by a joystick which is directly connected to the controller.
%   Each axis of the controller can only be controlled by one joystick axis.
%   See "Joystick Control" in the controller User Manual for details.
%
%   SYNTAX
%       PIdevice.JAX(iJoyID,iJoyAxesID,sAxisNames)
% 
%   INPUT
%       iJoyID (int)                        joystick device connected to the controller
%
%       iAxesID (int)                       IDs of the joystick axes 
%
%       szAxesBuffer (char array)           name(s) of the axis or axes to be controlled by this joystick axis
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,iJoyID,iJoyAxesID,sAxisNames);
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
