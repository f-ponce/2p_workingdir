function  NAV(c,AnalogChannelId,NrReadingsValues)
%   DESCRIPTION
%   Determines the number of readout values of the analog input that are averaged. 
%
%   SYNTAX
%       PIdevice.NAV(AnalogChannelId,NrReadingsValues)
% 
%   INPUT
%       AnalogChannelId (int array)         identifier of the analog input channel
%
%       NrReadingsValues (int array)        number of readout values of the analog signal
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	pAnalogChannelId = libpointer('int32Ptr',AnalogChannelId);
	pNrReadingsValues = libpointer('int32Ptr',NrReadingsValues);
	nValues = length(NrReadingsValues);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,pAnalogChannelId,pNrReadingsValues,nValues);
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
