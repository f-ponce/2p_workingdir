function [iDeviceIDs, iAxesIDs] = qHIA(c,szAxes,iFunctions)
%   DESCRIPTION
%   Gets the current control configuration for the given motion parameter of the given axis of the controller, 
%   i. e. the currently assigned axis of an HID device.
%
%   SYNTAX
%       [iDeviceIDs, iAxesIDs] = PIdevice.qHIA(szAxes,iFunctions)
% 
%   INPUT
%       szAxes (char array)                 string with axes of the controller
%
%       iFunctions (int array)              motion parameters to be queried
%
%   OUTPUT
%       [iDeviceIDs] (int array)            IDs of the HID devices used for HID control
%
%       [iAxesIDs] (int array)              IDs of the axes of the HID device(s) used for HID control
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	if(nargin==1)
		szAxes = '';
    end
    len = GetNrAxesInString(c,szAxes);
    
    if(len == 0)
			if(~c.initialized) error('Controller must be initialized when no axes ID is given');end;
			len = c.NumberOfAxes * 4;
	end
	if(len == 0)
		return;
	end
    
	if(nargin==1)
		szAxes = char(ones(8,1) * ' ');
    end
    
	if(nargin<2)
        iFunctions = zeros(len,1);
	end
    
	iAxesIDs =  zeros(len,1);
    iDeviceIDs =  zeros(len,1);
	piAxesIDs = libpointer('int32Ptr',iAxesIDs);
	piDeviceIDs = libpointer('int32Ptr',iDeviceIDs);
	piFunctions = libpointer('int32Ptr',iFunctions);
	try
		[bRet,~,~,iDeviceIDs,iAxesIDs] = calllib(c.libalias,functionName,c.ID,szAxes,piFunctions,piDeviceIDs,piAxesIDs);
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
