function WOS(c,iWaveTableIdsArray,dInValues)
%   DESCRIPTION
%   Sets an offset to the output of a wave generator. The current wave generator output is then created by 
%   adding the offset value to the current wave value:
%   Generator Output = Offset + Current Wave Value
%   Do not confuse the output-offset value set with WOS() with the offset settings done during the 
%   waveform creation with the WAV() functions. While the WAV() offset belongs to only one 
%   waveform, the WOS() offset is added to all waveforms which are output by the given wave generator.
%   Deleting wave table content with WCL() has no effect on the offset settings for the  wave generator 
%   output.
%
%   SYNTAX
%       PIdevice.WOS(iWaveTableIdsArray,dInValues)
% 
%   INPUT
%       iWaveTableIdsArray (int array)      array with wave generators. 
%
%       dInValues (double array)            array with the offsets of the wave generators. 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piWaveTableIdsArray = libpointer('int32Ptr',iWaveTableIdsArray);
	pdInValues = libpointer('doublePtr',dInValues);
	nValues = length(iWaveTableIdsArray);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,piWaveTableIdsArray,pdInValues,nValues);
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
