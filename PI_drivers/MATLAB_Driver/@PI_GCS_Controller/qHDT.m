function [iValue] = qHDT(c,iDeviceID,iAxis_ID)
%   DESCRIPTION
%   Gets the currently assigned lookup table for the given axis of the given HID device.
%
%   SYNTAX
%       [iValue] = PIdevice.qHDT(iDeviceID,iAxis_ID)
% 
%   INPUT
%       iDeviceID (int array)           HID devices connected to the controller.
%
%       iAxis_ID (int array)            axes of the HID device(s)
%
%   OUTPUT
%       [iValue] (int array)            lookup tables assigned to the axes of the HID device(s),
%                                       see HDT() for available tables
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    
    if(length(iDeviceID) ~= length(iAxis_ID))
        return;
    end
    
    len = length(iDeviceID);
	iValue = zeros(len,1);
	piDeviceID = libpointer('int32Ptr',iDeviceID);
	piAxis_ID = libpointer('int32Ptr',iAxis_ID);
	piValue = libpointer('int32Ptr',iValue);
	try
		[bRet,~, ~, iValue] = calllib(c.libalias,functionName,c.ID,piDeviceID,piAxis_ID,piValue,len);
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
