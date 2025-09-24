function [iTriggerOptions, szBuffer] = qDRT(c,iChannels)
%   DESCRIPTION
%   Returns the current trigger source setting for the given data recorder table.
%
%   SYNTAX
%       [iTriggerOptions, szBuffer] = PIdevice.qDRT(iChannels)
% 
%   INPUT
%       iChannels (int array)               array of the record table IDs
%
%   OUTPUT
%       [iTriggerOptions] (int array)       array to receive the trigger source
%
%       [szBuffer] (char array)             buffer to receive the trigger-source-dependent value
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piChannels = libpointer('int32Ptr',iChannels);
	iTriggerOptions = zeros(size(iChannels));
	piTriggerOptions = libpointer('int32Ptr',iTriggerOptions);
	nValues = length(iTriggerOptions);
	szBuffer = blanks(2049);
	try
		[bRet,~,iTriggerOptions,szBuffer] = calllib(c.libalias,functionName,c.ID,piChannels,piTriggerOptions,szBuffer,nValues,2048);
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
