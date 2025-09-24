function [iValue] = qHIL(c,iDeviceID,iLED_ID)
%   DESCRIPTION
%   Gets the current state of the given output unit or characteristic ("LED") of the given HID device.
%
%   SYNTAX
%       [iValue] = PIdevice.qHIL(iDeviceID,iLED_ID)
% 
%   INPUT
%       iDeviceID (int array)      HID devices connected to the controller
%
%       iLED_ID (int array)        output units or characteristics ("LEDs") of the HID device(s)
%
%   OUTPUT
%       [iValue] (int array)       array to receive the states of the LEDs
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    
    if(length(iDeviceID) ~= length(iLED_ID))
        return;
    end
    
    len = length(iDeviceID);
	iValue = zeros(len,1);
	piDeviceID = libpointer('int32Ptr',iDeviceID);
	piLED_ID= libpointer('int32Ptr',iLED_ID);
	piValue = libpointer('int32Ptr',iValue);
	try
		[bRet,~,~,iValue] = calllib(c.libalias,functionName,c.ID,piDeviceID,piLED_ID,piValue,len);
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
