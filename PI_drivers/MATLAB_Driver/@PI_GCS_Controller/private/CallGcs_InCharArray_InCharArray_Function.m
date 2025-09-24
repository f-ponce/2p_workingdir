function CallGcs_InCharArray_InCharArray_Function(c, sGcsFunctionName, CharArray1,CharArray2)
%PI MATLAB Class Library Version 1.6.0
% This code is provided by Physik Instrumente(PI) GmbH&Co.KG.
% You may alter it corresponding to your needs.
% Comments and Corrections are very welcome.
% Please contact us by mailing to support-software@pi.ws. Thank you.
if(c.ID<0), error('The controller is not connected'),end;
CharArray1 = ConvertCellArrayStringToString (CharArray1);
CharArray2 = ConvertCellArrayStringToString (CharArray2);
functionName = [ c.libalias, '_', sGcsFunctionName];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,CharArray1,CharArray2);
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