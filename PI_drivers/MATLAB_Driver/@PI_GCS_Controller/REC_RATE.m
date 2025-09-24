function REC_RATE(c,recorderId,rate)
%   DESCRIPTION
%   
%   Sets the sample rate of the data recorder.
%   A data recorder can only be configured if it is in the state 'configuration'.
%    
%
%   SYNTAX
%        PIdevice.REC_RATE(recorderId,rate)
% 
%   INPUT
%       recorderId (char array)            The data recorder whose recording rate is to be set
%
%       rate (int)                         The sample rate
%   
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end
recorderId = ConvertCellArrayStringToString (recorderId);
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,recorderId,rate);
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