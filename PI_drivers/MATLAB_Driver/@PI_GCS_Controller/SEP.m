function SEP(c,szPassword,szAxes,uiInParamIDs,dInValues,szInString)
%   DESCRIPTION
%   Set specified parameters for szAxes in non-volatile memory. For each parameter you must specify a 
%   designator in szAxes, and the parameter ID in the corresponding element of iParameterArray. See the 
%   user manual of the controller for a list of available parameters.
%
%   Warnings:
%   This command is for setting hardware-specific parameters. Wrong values may lead to improper 
%   operation or damage of your hardware!
%   The number of write times of non-volatile memory is limited. Do not write parameter values except 
%   when necessary.
%
%   SYNTAX
%       PIdevice.SEP(szPassword,szAxes,uiInParamIDs,dInValues,szInString)
% 
%   INPUT
%       szPassword (char array)             There is a password required to set parameters in the non-volatile memory.
%                                           This password is “100”
%
%       szAxes (char array)                 string with designators, one parameter is set for each designator in szAxes
%
%       uiInParamIDs (int array)            Parameter IDs
%
%       dInValues (double array)            array with the values for the respective parameters 
%
%       szInString (char array)             string with linefeed-separated parameter values; when not needed set to NULL 
%                                           (i.e. if numeric parameter values are used)
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	if(nargin<6),szInString = '';end
	puiInParIDs = libpointer('uint32Ptr',uiInParamIDs);
	pdInValues = libpointer('doublePtr',dInValues);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,szPassword,szAxes,puiInParIDs,pdInValues,szInString);
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
