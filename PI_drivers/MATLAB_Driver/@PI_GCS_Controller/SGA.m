function SGA(c,iAnalogChannelIds,iGainValues)
%   DESCRIPTION
%   Determines the gain value for the given analog input channel.
%
%   SYNTAX
%       PIdevice.SGA(iAnalogChannelIds,iGainValues)
% 
%   INPUT
%       iAnalogChannelIds (int array)       array of analog input channel identifiers
%
%       iGainValues (int array)             array of gain factors
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piAnalogChannelIds = libpointer('int32Ptr',iAnalogChannelIds);
	piGainValues2 = libpointer('int32Ptr',iGainValues);
	nValues = length(iAnalogChannelIds);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,piAnalogChannelIds,piGainValues2,nValues);
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
