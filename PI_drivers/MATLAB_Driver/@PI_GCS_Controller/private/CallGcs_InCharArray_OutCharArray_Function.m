function [usg] = CallGcs_InCharArray_OutCharArray_Function(c,sGcsFunctionName,chapter)
%PI MATLAB Class Library Version 1.6.0
% This code is provided by Physik Instrumente(PI) GmbH&Co.KG.
% You may alter it corresponding to your needs.
% Comments and Corrections are very welcome.
% Please contact us by mailing to support-software@pi.ws. Thank you.
if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', sGcsFunctionName];
if(any(strcmp(functionName,c.dllfunctions)))
    usg = blanks(100001);
    if (nargin == 2)
        chapter = '';
    end
	try
		[bRet,~,usg] = calllib(c.libalias,functionName,c.ID,chapter,usg,100000);
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