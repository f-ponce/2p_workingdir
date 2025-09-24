function  RPA(c,sAxes,uiParIDs)
%   DESCRIPTION
%   Copy specified parameters for szAxes from the non-volatile memory and write them to RAM. For each 
%   desired parameter you must specify a designator in szAxes, and the parameter ID in the corresponding 
%   element of iParameterArray. See the user manual of the controller for a list of available parameters.
%
%   SYNTAX
%       PIdevice.RPA(sAxes, uiParIDs)
% 
%   INPUT
%       sAxes (char array)          string with designators, one parameter is copied for each designator in sAxes
%
%       uiParIDs (int array)        parameter IDs
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	puiParIDs = libpointer('uint32Ptr',uiParIDs);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,sAxes,puiParIDs);
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
