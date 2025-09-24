function [statesBuffer] = qREC_STATE(c,recorderIds)
%   DESCRIPTION
%   
%   Gets the current state of the recorded data.
%    
%
%   SYNTAX
%        [statesBuffer] = PIdevice.qREC_STATE(recorderIds)
% 
%   INPUT
%       recorderIds (char array)                 The data recorder(s) whose status is to be queried
%
%   OUTPUT
%       [statesBuffer] (char array)              The current state of the data recorder
%      
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end
if(nargin==1)
        recorderIds = '';
end
recorderIds = ConvertCellArrayStringToString (recorderIds);
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    statesBuffer =  blanks(10001);
	try
		[bRet,~,statesBuffer] = calllib(c.libalias,functionName,c.ID,recorderIds,statesBuffer,10000);
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