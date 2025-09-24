function [iOutValues] = qATC(c,iInValues)
%   DESCRIPTION
%   Get the options used for the latest auto calibration procedure started with ATC().
%   See "Calibration Settings" in the User Manual of the controller for more information.
%
%   SYNTAX
%       [iOutValues] = PIdevice.qATC(iInValues)
% 
%   INPUT
%       iInValues (int array)       array with channels of the piezo control electronics
%
%   OUTPUT
%       [iOutValues] (int array)    comprises the settings of the latest auto calibration procedure.
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piValues = libpointer('int32Ptr',iInValues);
	iOutValues = zeros(size(iInValues));
	piOutValues = libpointer('int32Ptr',iOutValues);
	nValues = length(iInValues);
	try
		[bRet,~,iOutValues] = calllib(c.libalias,functionName,c.ID,piValues,piOutValues,nValues);
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
