function HDT(c,iDeviceID,iAxis_ID,iValue)
%   DESCRIPTION
%   Assigns a lookup table to the given axis of the given HID device.
%
%   SYNTAX
%       PIdevice.HDT(iDeviceID,iAxis_ID,iValue)
% 
%   INPUT
%       iDeviceID (int array)           HID devices connected to the controller
%
%       iAxis_ID (int array)            axes of the HID device(s)
%
%       iValue (int array)              lookup tables to be assigned.
%                                       Supported tables depend on the controller.
%                                       Possible tables (ID: type):
%                                           1: linear
%                                           2: parabolic
%                                           3: cubic
%                                           4: exponential
%                                           5: inverted linear
%                                           6: inverted parabolic
%                                           101 or higher: user-defined tables
% 
%   PI MATLAB Class Library Version 1.5.0     
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    
    if((length(iDeviceID) ~= length(iAxis_ID)) || (length(iDeviceID) ~= length(iValue))) 
        return;
    end
    
    len = length(iDeviceID);
	piDeviceID = libpointer('int32Ptr',iDeviceID);
	piAxis_ID = libpointer('int32Ptr',iAxis_ID);
	piValue = libpointer('int32Ptr',iValue);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,piDeviceID,piAxis_ID,piValue,len);
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
