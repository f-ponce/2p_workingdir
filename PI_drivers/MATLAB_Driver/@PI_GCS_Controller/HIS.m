function HIS(c,iDeviceID,iItemID,iPropertyID,szValues)
%   DESCRIPTION
%   Configures the given HID device.
%
%   SYNTAX
%       PIdevice.HIS(iDeviceID,iItemID,iPropertyID,szValues)
% 
%   INPUT
%       iDeviceID (int array)       HID devices connected to the controller
%
%       iItemID (int array)         operating elements of the HID device(s)
%
%       iPropertyID (int array)     properties of the operating elements of the HID device(s)
%
%       szValues (char array)       string with the values to which the properties of the
%                                   operating elements are to be set
%  
%   PI MATLAB Class Library Version 1.5.0    
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    
    if((length(iDeviceID) ~= length(iItemID)) || (length(iDeviceID) ~= length(iPropertyID))) 
        return;
    end
    
    len = length(iDeviceID);
	piDeviceID = libpointer('int32Ptr',iDeviceID);
	piItemID= libpointer('int32Ptr',iItemID);
	piPropertyID = libpointer('int32Ptr',iPropertyID);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,piDeviceID,piItemID,piPropertyID,szValues,len);
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
