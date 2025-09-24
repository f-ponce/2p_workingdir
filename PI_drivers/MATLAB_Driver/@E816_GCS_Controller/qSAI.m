function szAnswer = qSAI(c)
% function szAnswer = qSAI(c)

% This code is provided by Physik Instrumente(PI) GmbH&Co.KG.
% You may alter it corresponding to your needs.
% Comments and Corrections are very welcome.
% Please contact us by mailing to c.wurm@pi.ws. Thank you.

if(c.ID<0), error('The controller is not connected'),end;
FunctionName = 'E816_qSAI';
if(strmatch(FunctionName,c.dllfunctions))
	szAnswer = blanks(5001);
	try
		[bRet,szAnswer] = calllib(c.libalias,FunctionName,c.ID,szAnswer,5000);
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
