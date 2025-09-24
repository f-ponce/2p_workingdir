function [iErr] = GetError(c)
%function [iErr] = GetError(c)

% This code is provided by Physik Instrumente(PI) GmbH&Co.KG.
% You may alter it corresponding to your needs.
% Comments and Corrections are very welcome.
% Please contact us by mailing to c.wurm@pi.ws. Thank you.

if(c.ID<0), error('The controller is not connected'),end;
FunctionName = 'E816_GetError';
if(strmatch(FunctionName,c.dllfunctions))
	try
		[iErr] = calllib(c.libalias,FunctionName,c.ID);
	catch
		rethrow(lasterror);
	end
else
	error(sprintf('%s not found',FunctionName));
end
