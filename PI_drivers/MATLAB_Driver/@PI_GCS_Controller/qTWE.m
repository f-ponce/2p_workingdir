function [piWaveTableStartIndexArray,piWaveTableEndIndexArray] = qTWE(c,piWaveTableIdsArray)  
%   DESCRIPTION
%   
%   Get the trigger definition set with TWE().  
%    
%
%   SYNTAX
%        [piWaveTableStartIndexArray,piWaveTableEndIndexArray] = PIdevice.qTWE(piWaveTableIdsArray)
% 
%   INPUT
%       piWaveTableIdsArray (int array)                           wave table of the controller             
%
%   OUTPUT
%       [piWaveTableStartIndexArray] (int array) 
%
%       [piWaveTableEndIndexArray] (int array)
%      
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    piWaveTableStartIndexArray = zeros(1,1); % zeros(,1)
	piWaveTableStartIndexArray = libpointer('int32Ptr',piWaveTableStartIndexArray);
    piWaveTableEndIndexArray = zeros(1,1); % zeros(,1)
	piWaveTableEndIndexArray = libpointer('int32Ptr',piWaveTableEndIndexArray);
    piWaveTableIdsArray = libpointer('int32Ptr',piWaveTableIdsArray);
	try
		[bRet,~,piWaveTableStartIndexArray,piWaveTableEndIndexArray] = calllib(c.libalias,functionName,c.ID,piWaveTableIdsArray,piWaveTableStartIndexArray,piWaveTableEndIndexArray,length(piWaveTableIdsArray));
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