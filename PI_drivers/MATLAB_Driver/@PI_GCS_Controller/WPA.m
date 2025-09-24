function WPA(c,sPassWd,sAxes,uiParIDs)
%   DESCRIPTION
%   Gets values of the specified parameters from RAM and copies them to non-volatile memory. For each 
%   parameter you must specify a designator in szAxes and the parameter ID in the corresponding element of 
%   iParameterArray. See the user manual of the controller for a list of available parameters.
%   NOTICE: If current parameter values are incorrect, the system may malfunction. Be sure that you have the 
%   correct parameter settings before using WPA().
%   Settings not saved with WPA() will be lost when the controller is powered off or rebooted.
% 
%   SYNTAX
%       PIdevice.WPA(sPassWd,sAxes,uiParIDs)
% 
%   INPUT
%       sPassWd (char array)        The password for writing to non-volatile memory depends on the parameter.
%                                   See the parameter overview and the description of the 
%                                   WPA command in the user manual of the controller.
%
%       sAxes (char array)          string with designators. 
%                                   For each designator in szAxes one parameter value is copied.
%
%       uiParIDs (int array)        Array with parameter IDs
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    if(nargin<3),sAxes = '';uiParIDs=[];end
	puiParIDs = libpointer('uint32Ptr',uiParIDs);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,sPassWd,sAxes,puiParIDs);
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
