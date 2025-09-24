function WGO(c,iWaveGeneratorIdsArray,iStartModArray)
%   DESCRIPTION
%   Start and stop the specified wave generator with the given mode. Depending on the controller, starts also 
%   data recording.
%
%   SYNTAX
%       PIdevice.WGO(iWaveGeneratorIdsArray,iStartModArray)
% 
%   INPUT
%       iWaveGeneratorIdsArray (int array)      array with wave generators.
%
%       iStartModArray (int array)              array with start modes for each wave generator in piWaveGeneratorIdsArray
%                                               (hex format, optional decimal format)
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piWaveGeneratorIdsArray = libpointer('int32Ptr',iWaveGeneratorIdsArray);
	piStartModArray = libpointer('int32Ptr',iStartModArray);
	nValues = length(iWaveGeneratorIdsArray);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,piWaveGeneratorIdsArray,piStartModArray,nValues);
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
