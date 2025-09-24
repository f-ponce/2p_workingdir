function [triggerConfigurationBuffer] = qREC_TRG(c,recorderIds)
%   DESCRIPTION
%   
%   Gets the trigger configuration of the data recorder.
%    
%
%   SYNTAX
%        [triggerConfigurationBuffer] = PIdevice.qREC_TRG(recorderIds)
% 
%   INPUT
%       recorderIds (char array)                          The data recorder(s) whose configuration is to be queried
%
%   OUTPUT
%       [triggerConfigurationBuffer] (char array)         The trigger configuration of the data recorder(s).
%      
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end
if(nargin==1)
        recorderIds = '';
end
recorderIds = ConvertCellArrayStringToString (recorderIds);
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    triggerConfigurationBuffer =  blanks(10001);
	try
		[bRet,~,triggerConfigurationBuffer] = calllib(c.libalias,functionName,c.ID,recorderIds,triggerConfigurationBuffer,10000);
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
