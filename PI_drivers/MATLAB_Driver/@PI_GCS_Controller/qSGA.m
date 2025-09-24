function [iOutValues] = qSGA(c,iInValues)
%   DESCRIPTION
%   Gets the gain value piGainValues for the given analog input channel piAnalogChannelIds.
%   The response consists of a line feed when the controller does not contain an optical analog input channel. 
%
%   SYNTAX
%       [iOutValues] = PIdevice.qSGA(iInValues)
% 
%   INPUT
%       iInValues (int array)       identifier of the analog input channel
%
%   OUTPUT
%       [iOutValues] (int array)    array to be filled with gain factor values
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
