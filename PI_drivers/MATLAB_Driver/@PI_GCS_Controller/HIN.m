function HIN(c,szAxes,bValues)
%   DESCRIPTION
%   Enables or disables the control by HID devices ("HID control") for the given axis of the controller.
%
%   SYNTAX
%       PIdevice.HIN(szAxes, bValues)
% 
%   INPUT
%       szAxes (char array)             string with axes of the controller
%
%       bValues (int array)             activation state of the HID control for the specified controller axes,
%                                       1 for "enabled", 0 for "disabled"
% 
%   PI MATLAB Class Library Version 1.5.0     
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
szAxes = ConvertCellArrayStringToString (szAxes);
if(any(strcmp(functionName,c.dllfunctions)))
	pbValues = libpointer('int32Ptr',bValues);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,szAxes,pbValues);
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
