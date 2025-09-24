function [szDevices] = EnumerateUSB(c,szFilter)
%function [szDevices] = EnumerateUSB(c,szFilter)

% This code is provided by Physik Instrumente(PI) GmbH&Co.KG.
% You may alter it corresponding to your needs.
% Comments and Corrections are very welcome.
% Please contact us by mailing to c.wurm@pi.ws. Thank you.

FunctionName = 'E816_EnumerateUSB';
if(strmatch(FunctionName,c.dllfunctions))
	szDevices = blanks(1001);
	try
		[bRet,szDevices,szFilter] = calllib(c.libalias,FunctionName,szDevices,1000,szFilter);
		if(bRet==0)
			iError = GetError(c);
			szDesc = TranslateError(c,iError);
			error(szDesc);
		end
	catch
		rethrow(lasterror);
	end
else
	error(sprintf('%s not found',FunctionName));
end
