function HIL(c,iDeviceID,iLED_ID,iValue)
%   DESCRIPTION
%   Sets the current state of the given output unit or characteristic ("LED") of the given HID device.
%
%   SYNTAX
%       PIdevice.HIL(iDeviceID,iLED_ID,iValue)
% 
%   INPUT
%       iDeviceID (int array)          HID devices connected to the controller
%
%       iLED_ID (int array)            output units or characteristics ("LEDs") of the HID device(s)
%
%       iValue (int array)             states to be set for the output units or characteristics of the HID device(s)            
%  
%   PI MATLAB Class Library Version 1.5.0    
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    
    if((length(iDeviceID) ~= length(iLED_ID)) || (length(iDeviceID) ~= length(iValue))) 
        return;
    end
    
    len = length(iDeviceID);
	piDeviceID = libpointer('int32Ptr',iDeviceID);
	piLED_ID = libpointer('int32Ptr',iLED_ID);
	piValue = libpointer('int32Ptr',iValue);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,piDeviceID,piLED_ID,piValue,len);
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
