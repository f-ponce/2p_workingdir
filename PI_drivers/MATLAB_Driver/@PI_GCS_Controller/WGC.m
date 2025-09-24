function WGC(c,iWaveGeneratorIdsArray,iNumberOfCyclesArray)
%   DESCRIPTION
%   Set the number of cycles for the wave generator output (which is started with WGO()).
%
%   SYNTAX
%       PIdevice.WGC(iWaveGeneratorIdsArray,iNumberOfCyclesArray)
% 
%   INPUT
%       iWaveGeneratorIdsArray (int array)          array with wave generators 
%
%       iNumberOfCyclesArray (int array)            array with number of cycles for each wave generator in 
%                                                   piWaveGeneratorIdsArray
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piWaveGeneratorIdsArray = libpointer('int32Ptr',iWaveGeneratorIdsArray);
	piNumberOfCyclesArray = libpointer('int32Ptr',iNumberOfCyclesArray);
	nValues = length(iWaveGeneratorIdsArray);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,piWaveGeneratorIdsArray,piNumberOfCyclesArray,nValues);
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
