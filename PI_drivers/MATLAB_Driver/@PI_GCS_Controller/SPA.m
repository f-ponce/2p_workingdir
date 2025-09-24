function SPA(c,szAxes,uiInParamIDs,dInValues,szInString)
%   DESCRIPTION
%   Set specified parameters for szAxes in RAM. For each parameter you must specify a designator in 
%   szAxes, and the parameter ID in the corresponding element of iParameterArray. See the user manual of 
%   the controller for a list of available parameters.
%   If the same designator has the same parameter number more than once, only the last value will be 
%   set. For example SPA(id, "111", {0x1, 0x1, 0x2}, {3e-2, 2e-2, 2e-4}) will set the P-term of '1' to 2e-2
%   and the I-term to 2e-4.
%
%   SYNTAX
%       PIdevice.SPA(szAxes,uiInParamIDs,dInValues,szInString)
% 
%   INPUT
%       szAxes (char array)             string with designators, one parameter is set for each designator in szAxes
%
%       uiInParamIDs (int array)        Parameter IDs
%
%       dInValues (double array)        array to receive with the values for the respective parameters 
%
%       szInString (char array)         string, with linefeed-separated parameter values; when not needed set to NULL 
%                                       (i.e. if numeric parameter values are used)
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	if(nargin<5),szInString = '';end,
	puiInParIDs = libpointer('uint32Ptr',uiInParamIDs);
	pdInValues = libpointer('doublePtr',dInValues);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,szAxes,puiInParIDs,pdInValues,szInString);
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
