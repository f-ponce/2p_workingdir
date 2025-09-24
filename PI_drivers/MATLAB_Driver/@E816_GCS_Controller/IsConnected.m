function [bRet] = IsConnected(c)
%function [bRet] = IsConnected(c)

% This code is provided by Physik Instrumente(PI) GmbH&Co.KG.
% You may alter it corresponding to your needs.
% Comments and Corrections are very welcome.
% Please contact us by mailing to c.wurm@pi.ws. Thank you.

functionName = [ c.libalias, '_', mfilename];
if(strmatch(functionName,c.dllfunctions))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID);
	catch
		rethrow(lasterror);
	end
else
	error(sprintf('%s not found',FunctionName));
end
