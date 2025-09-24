function [dValue] = qHIE(c,iDeviceID,iAxesID)
%   DESCRIPTION
%   Gets the current displacement of the given axis of the given HID device.
%
%   SYNTAX
%       [dValue] = PIdevice.qHIE(iDeviceID,iAxesID)
% 
%   INPUT
%       iDeviceID (int array)           HID devices connected to the controller
%
%       iAxesID (int array)             axes of the HID device(s)
%
%   OUTPUT
%       [dValue] (double array)         array to receive the displacement of the axes of the HID device(s)
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    
    if(length(iDeviceID) ~= length(iAxesID))
        return;
    end
    
    len = length(iDeviceID);
	dValue = zeros(len,1);
	piDeviceID = libpointer('int32Ptr',iDeviceID);
	piAxesID= libpointer('int32Ptr',iAxesID);
	pdValue = libpointer('doublePtr',dValue);
	try
		[bRet,~,~,dValue] = calllib(c.libalias,functionName,c.ID,piDeviceID,piAxesID,pdValue,len);
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
