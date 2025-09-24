function [dValues] = qCTO(c,iTriggerOutputIds,iTriggerParameterArray)
%   DESCRIPTION
%   Get the trigger output configuration for the given trigger output line.
%
%   SYNTAX
%       [dValues] = PIdevice.qCTO(iTriggerOutputIds,iTriggerParameterArray)
% 
%   INPUT
%       iTriggerOutputIds (int array)           is an array with the trigger output lines of the controller
%
%       iTriggerParameterArray (int array)      is an array with the CTO parameter IDs
%
%   OUTPUT
%       [dValues] (double array)                buffer to receive the values to which the CTO parameters are set
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piTriggerOutputIds = libpointer('int32Ptr',iTriggerOutputIds);
	piTriggerParameterArray = libpointer('int32Ptr',iTriggerParameterArray);
	nValues = length(iTriggerOutputIds);
	dValues = zeros(size(iTriggerOutputIds));
	pdValues = libpointer('doublePtr',dValues);
	try
		[bRet,~,~,dValues] = calllib(c.libalias,functionName,c.ID,piTriggerOutputIds,piTriggerParameterArray,pdValues,nValues);
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
