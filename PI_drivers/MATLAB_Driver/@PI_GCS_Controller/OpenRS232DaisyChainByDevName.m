function c = OpenRS232DaisyChainByDevName(c,szDevName,iBaudRate,iNumberOfConnectedDaisyChainDevices, szDeviceIDN)
%PI MATLAB Class Library Version 1.2.0
% This code is provided by Physik Instrumente(PI) GmbH&Co.KG.
% You may alter it corresponding to your needs.
% Comments and Corrections are very welcome.
% Please contact us by mailing to support-software@pi.ws. Thank you.

% only load dll if it wasn't loaded before
if(~libisloaded(c.libalias))
	c = LoadGCSDLL(c);
end
if(c.DC_ID < 0)
    error('DaisyChain not open');
end
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piNumberOfConnectedDaisyChainDevices = libpointer('int32Ptr',iNumberOfConnectedDaisyChainDevices);
	try
		[c.ID] = calllib(c.libalias,functionName,szDevName,iBaudRate,piNumberOfConnectedDaisyChainDevices,szDeviceIDN,9999)
		if (c.ID<0)
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
