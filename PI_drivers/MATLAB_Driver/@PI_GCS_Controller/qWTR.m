function [piTableRateArray, piInterpolationTypeArray] = qWTR(c,iWaveGeneratorIdsArray)
%   DESCRIPTION
%   Gets the current wave generator table rate, i.e. the number of servo-loop cycles used for wave generator 
%   output. Gets also the interpolation type used with table rate values > 1.
%
%   SYNTAX
%       [piTableRateArray, piInterpolationTypeArray] = PIdevice.qWTR(iWaveGeneratorIdsArray)
% 
%   INPUT
%       iWaveGeneratorIdsArray (int array)          array with wave generators
%
%   OUTPUT
%       [piTableRateArray] (int array)              array to receive the wave table rate. 
%
%       [piInterpolationTypeArray] (int array)      array to receive the interpolation type. 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piWaveGeneratorIdsArray = libpointer('int32Ptr',iWaveGeneratorIdsArray);
	nValues = length(iWaveGeneratorIdsArray);
    iTableRateArray = zeros(size(iWaveGeneratorIdsArray));
    iInterpolationTypeArray = zeros(size(iWaveGeneratorIdsArray));
	piTableRateArray = libpointer('longPtr',iTableRateArray);
	piInterpolationTypeArray = libpointer('longPtr',iInterpolationTypeArray);
	try
		[bRet,~,piTableRateArray,piInterpolationTypeArray] = calllib(c.libalias,functionName,c.ID,piWaveGeneratorIdsArray,piTableRateArray,piInterpolationTypeArray,nValues);
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
