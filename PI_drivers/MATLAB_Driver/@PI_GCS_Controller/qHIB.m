function [iValue] = qHIB(c,iDeviceID,iButtonID)
%   DESCRIPTION
%   Gets the current state of the given button of the given HID device.
%
%   SYNTAX
%       [iValue] = PIdevice.qHIB(iDeviceID,iButtonID)
% 
%   INPUT
%       iDeviceID (int array)               HID devices connected to the controller
%
%       iButtonID (int array)               buttons of the HID device(s)
%
%   OUTPUT
%       [iValue] (int array)                array to receive the states of the buttons
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    
    if(length(iDeviceID) ~= length(iButtonID))
        return;
    end
    
    len = length(iDeviceID);
	iValue = zeros(len,1);
	piDeviceID = libpointer('int32Ptr',iDeviceID);
	piButtonID= libpointer('int32Ptr',iButtonID);
	piValue = libpointer('int32Ptr',iValue);
	try
		[bRet,~,~,iValue] = calllib(c.libalias,functionName,c.ID,piDeviceID,piButtonID,piValue,len);
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
