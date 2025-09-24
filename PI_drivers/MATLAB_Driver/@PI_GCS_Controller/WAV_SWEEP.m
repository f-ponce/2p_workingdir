function WAV_SWEEP(c,iWaveTableId,iAddAppendWave,iStarFequencytValueInPoints,iStopFrequencyValueInPoints,nLengthOfWave,dAmplitudeOfWave,dOffsetOfWave)
% function WAV_SWEEP(c,iWaveTableId,iAddAppendWave,iStarFequencytValueInPoints,iStopFrequencyValueInPoints,nLengthOfWave,dAmplitudeOfWave,dOffsetOfWave)
%PI MATLAB Class Library Version 1.2.0
% This code is provided by Physik Instrumente(PI) GmbH&Co.KG.
% You may alter it corresponding to your needs.
% Comments and Corrections are very welcome.
% Please contact us by mailing to support-software@pi.ws. Thank you.

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName, c.dllfunctions)))
    try
		[bRet] = calllib(c.libalias, functionName, c.ID, iWaveTableId,iAddAppendWave,iStarFequencytValueInPoints,iStopFrequencyValueInPoints,nLengthOfWave,dAmplitudeOfWave,dOffsetOfWave);
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
