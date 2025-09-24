function [iOutValues1] = qSEP_int64(c,szAxes,uiInParamIDs)
%function [dOutValues1,szAnswer] = qSEP_int64(c,szAxes,uiInParamIDs)
%PI MATLAB Class Library Version 1.2.0
% This code is provided by Physik Instrumente(PI) GmbH&Co.KG.
% You may alter it corresponding to your needs.
% Comments and Corrections are very welcome.
% Please contact us by mailing to support-software@pi.ws. Thank you.

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	puiInPars = libpointer('uint32Ptr',uiInParamIDs);
	iOutValues1 = zeros(size(uiInParamIDs));
	piOutValues1 = libpointer('int64Ptr',iOutValues1);
	try
		[bRet,~,~,iOutValues1] = calllib(c.libalias,functionName,c.ID,szAxes,puiInPars,piOutValues1);
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
