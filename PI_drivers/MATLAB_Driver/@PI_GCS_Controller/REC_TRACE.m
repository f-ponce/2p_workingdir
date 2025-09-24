function REC_TRACE(c,recorderId,traceId,containerUnitId,functionUnitId,parameterId)
%   DESCRIPTION
%   
%   Sets the configured data recorder traces.
%   A data recorder can only be configured if it is in the state 'configuration'.
%
%
%   SYNTAX
%        PIdevice.REC_TRACE(recorderId,traceId,containerUnitId,functionUnitId,parameterId)
% 
%   INPUT
%       recorderId (char array)               The data recorder whose trace is to be configured
%
%       traceId (int)                         The data recorder trace ID
%
%       containerUnitId (char array)          Container unit whose parameters are to be recorded
%
%       functionUnitId (char array)           Function unit whose parameters are to be recorded
% 
%       parameterId (char array)              The parameter ID 
% 
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
recorderId = ConvertCellArrayStringToString (recorderId);
containerUnitId = ConvertCellArrayStringToString (containerUnitId);
functionUnitId = ConvertCellArrayStringToString (functionUnitId);
parameterId = ConvertCellArrayStringToString (parameterId);
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,recorderId,traceId,containerUnitId,functionUnitId,parameterId);
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

