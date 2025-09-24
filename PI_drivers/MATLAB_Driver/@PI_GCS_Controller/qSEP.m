function [dOutValues1,szAnswer] = qSEP(c,szAxes,uiInParamIDs)
%   DESCRIPTION
%   Query specified parameters for szAxes from non-volatile memory. For each desired parameter you must 
%   specify a designator in szAxes and the parameter ID in the corresponding element of iParameterArray. 
%   See the user manual of the controller for a list of the available parameters.
%
%   SYNTAX
%       [dOutValues1,szAnswer] = PIdevice.qSEP(szAxes,uiInParamIDs)
% 
%   INPUT
%       szAxes (char array)             string with designator, one parameter is read for each designatorID in szAxes
%
%       uiInParamIDs (int array)        parameter IDs
%
%   OUTPUT
%       [dOutValues1] (double array)    array to receive the values of the requested parameters 
%
%       [szAnswer] (char array)         string to receive the with linefeed-separated parameter values;
%                                       when not needed set to NULL (i.e. if numeric parameter values are queried) 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	puiInPars = libpointer('uint32Ptr',uiInParamIDs);
	dOutValues1 = zeros(size(uiInParamIDs));
	pdOutValues1 = libpointer('doublePtr',dOutValues1);
	szAnswer = blanks(2049);
	try
		[bRet,~,~,dOutValues1,szAnswer] = calllib(c.libalias,functionName,c.ID,szAxes,puiInPars,pdOutValues1,szAnswer,2048);
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
