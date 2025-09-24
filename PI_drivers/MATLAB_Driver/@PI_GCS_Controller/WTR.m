function WTR(c,iWaveGeneratorIdsArray,iTableRateArray,iInterpolationTypeArray)
%   DESCRIPTION
%   Set wave generator table rate and interpolation type:
%   Using WTR(), you can "extend" the individual output cycles of the waveform. Depending on the 
%   controller, WTR() furthermore determines the type of interpolation to use for the wave generator 
%   output. If the Wave Generator Table Rate is larger than 1, an interpolation helps to avoid sudden position 
%   jumps of the axis controlled by the wave generator.
%
%   SYNTAX
%       PIdevice.WTR(iWaveGeneratorIdsArray,iTableRateArray,iInterpolationTypeArray)
% 
%   INPUT
%       iWaveGeneratorIdsArray (int array)          array with wave generator IDs.
%
%       iTableRateArray (int array)                 array with the wave table rates. 
%
%       iInterpolationTypeArray (int array)         array with the interpolation types. 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piWaveGeneratorIdsArray = libpointer('int32Ptr',iWaveGeneratorIdsArray);
	piTableRateArray = libpointer('int32Ptr',iTableRateArray);
	piInterpolationTypeArray = libpointer('int32Ptr',iInterpolationTypeArray);
	nValues = length(iWaveGeneratorIdsArray);
	try
        [bRet] = calllib(c.libalias,functionName,c.ID,piWaveGeneratorIdsArray,piTableRateArray,piInterpolationTypeArray,nValues);
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
