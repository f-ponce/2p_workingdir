function HIA(c,szAxes,iFunctions,iDeviceIDs,iAxesIDs)
%   DESCRIPTION
%   Configures the control of axes of the controller by axes of HID devices ("HID control"): Assigns an axis of 
%   an HID device to the given motion parameter of the given axis of the controller.
%
%   SYNTAX
%       PIdevice.HIA(szAxes,iFunctions,iDeviceIDs,iAxesIDs)
% 
%   INPUT
%       szAxes (char array)             axes of controller
%
%       iFunctions (int array)          motion parameters to be controlled by the axes of HID devices
%
%       iDeviceIDs (int array)          HID devices connected to the controller
%
%       iAxesIDs (int array)            axes of the HID device(s)
%   
%   PI MATLAB Class Library Version 1.5.0   
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
szAxes = ConvertCellArrayStringToString (szAxes);
if(any(strcmp(functionName,c.dllfunctions)))
	piFunctions = libpointer('int32Ptr',iFunctions);
	piDeviceIDs = libpointer('int32Ptr',iDeviceIDs);
	piAxesIDs = libpointer('int32Ptr',iAxesIDs);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,szAxes,piFunctions,piDeviceIDs,piAxesIDs);
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
