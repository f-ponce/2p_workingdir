function [dValues] = qWAV(c,iWaveTableIdsArray,iParamereIdsArray)
%   DESCRIPTION
%   Get the parameters for a defined waveform. For each desired parameter you must specify a 
%   wave table in piWaveTableIdsArray and a parameter ID in the corresponding element of 
%   piParameterIdsArray. The following parameter ID is valid: 
%   1: Number of waveform points for currently defined wave.
%
%   SYNTAX
%       [dValues] = PIdevice.qWAV(iWaveTableIdsArray,iParamereIdsArray)
% 
%   INPUT
%       iWaveTableIdsArray (int array)      array with wave table IDs for which the parameter(s) should be read 
%
%       iParamereIdsArray (int array)       array with IDs of requested parameters      
%
%   OUTPUT
%       [dValues] (double array)            array to be filled with the values for the parameters 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piWaveTableIdsArray = libpointer('int32Ptr',iWaveTableIdsArray);
	piParamereIdsArray1 = libpointer('int32Ptr',iParamereIdsArray);
	nValues = length(iWaveTableIdsArray);
	dValues = zeros(size(iWaveTableIdsArray));
	pdValues = libpointer('doublePtr',dValues);
	try
		[bRet,~,~,dValues] = calllib(c.libalias,functionName,c.ID,piWaveTableIdsArray,piParamereIdsArray1,pdValues,nValues);
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
