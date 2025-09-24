function SCN(c,iSensorsChannelsArray,iValues)
%function SCN(c,iSensorsChannelsArray,iValues)
%PI MATLAB Class Library Version 1.2.0
% This code is provided by Physik Instrumente(PI) GmbH&Co.KG.
% You may alter it corresponding to your needs.
% Comments and Corrections are very welcome.
% Please contact us by mailing to support-software@pi.ws. Thank you.

functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piSensorsChannelsArray = libpointer('int32Ptr',iSensorsChannelsArray);
	piValues = libpointer('int32Ptr',iValues);
	nValues = length(iSensorsChannelsArray);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,piSensorsChannelsArray,piValues,nValues);
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
