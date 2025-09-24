function [bValues] = qHIN(c,szAxes)
%   DESCRIPTION
%   Gets the activation state of the control by HID devices ("HID control") for the given axis of the controller.
%
%   SYNTAX
%       [bValues] = PIdevice.qHIN(szAxes) 
% 
%   INPUT
%       szAxes (char array)         string with axes
%
%   OUTPUT
%       [bValues] (int array)       array to receive the activation state of the HID control
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	if(nargin==1)
		szAxes = '';
	end
	len = GetNrAxesInString(c,szAxes);
	if(len == 0)
			if(~c.initialized) error('Controller must be initialized when no axes ID is given');end;
			len = c.NumberOfAxes;
	end
	if(len == 0)
		return;
	end
    
    
	bValues = zeros(len,1);
	piValue = libpointer('int32Ptr',bValues);
	try
		[bRet,~,bValues] = calllib(c.libalias,functionName,c.ID,szAxes,piValue);
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
