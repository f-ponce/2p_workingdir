function [szAnswer] = TranslateError(c,iErrorCode)
%function [szAnswer] = TranslateError(c,iErrorCode)

% This code is provided by Physik Instrumente(PI) GmbH&Co.KG.
% You may alter it corresponding to your needs.
% Comments and Corrections are very welcome.
% Please contact us by mailing to c.wurm@pi.ws. Thank you.

FunctionName = 'E816_TranslateError';
if(strmatch(FunctionName,c.dllfunctions))
	szAnswer = blanks(1001);
	try
		[bRet,szAnswer] = calllib(c.libalias,FunctionName,iErrorCode,szAnswer,1000);
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
