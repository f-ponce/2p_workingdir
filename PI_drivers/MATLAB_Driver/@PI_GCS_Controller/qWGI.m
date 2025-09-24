function [piValueArray] = qWGI(c,piWaveGeneratorIdsArray)  
%   DESCRIPTION
%   
%   Get index of the currently output wave point.
%      
%
%   SYNTAX
%        [piValueArray] = PIdevice.qWGI(piWaveGeneratorIdsArray)  
% 
%   INPUT
%       piWaveGeneratorIdsArray (int array)             Wave generator ID                       
%
%   OUTPUT
%       [piValueArray] (int array)                      index of the currently output wave point       
%      
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    piValueArray = zeros(1,1); 
	piValueArray = libpointer('int32Ptr',piValueArray);
    piWaveGeneratorIdsArray = libpointer('int32Ptr',piWaveGeneratorIdsArray);
	try
		[bRet,~,piValueArray] = calllib(c.libalias,functionName,c.ID,piWaveGeneratorIdsArray,piValueArray,length(piWaveGeneratorIdsArray));
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