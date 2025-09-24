function [c] = ConnectUSB(c,szIdentifier)
%function [c] = ConnectUSB(c,szIdentifier)

% This code is provided by Physik Instrumente(PI) GmbH&Co.KG.
% You may alter it corresponding to your needs.
% Comments and Corrections are very welcome.
% Please contact us by mailing to c.wurm@pi.ws. Thank you.

FunctionName = 'E816_ConnectUSB';
if(strmatch(FunctionName,c.dllfunctions))
	if(nargin<2),    szIdentifier = '';end,
	try
		[c.ID, szIdentifier] = calllib(c.libalias,FunctionName,szIdentifier);
		if(c.ID<0)
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
