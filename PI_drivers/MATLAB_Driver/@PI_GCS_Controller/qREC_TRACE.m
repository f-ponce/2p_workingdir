function [traceConfigurationBuffer] = qREC_TRACE(c,recorderId,traceIndex)
%   DESCRIPTION
%   
%   Gets the configured data recorder traces.
%    
%
%   SYNTAX
%        [traceConfigurationBuffer] = PIdevice.qREC_TRACE(recorderId,traceIndex)
% 
%   INPUT
%       recorderId (char array)                            The data recorder whose configuration is to be queried
%
%       traceIndex (int)                                   The data recorder trace ID
%       
%   OUTPUT
%       [traceConfigurationBuffer] (char array)            The configurations of the data recorder traces
%      
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end
recorderId = ConvertCellArrayStringToString (recorderId);
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    traceConfigurationBuffer =  blanks(10001);
	try
		[bRet,~,traceConfigurationBuffer] = calllib(c.libalias,functionName,c.ID,recorderId,traceIndex,traceConfigurationBuffer,10000);
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
