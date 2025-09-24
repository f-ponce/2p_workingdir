function [dValues] = CallGcs_InAxes_OutDoubleArray_Function(c, sGcsFunctionName, szAxes)
% function [dValues] = CallGcs_InAxes_OutDoubleArray_Function(c,sGcsFunctionName, szAxes)
%PI MATLAB Class Library Version 1.2.0
% This code is provided by Physik Instrumente(PI) GmbH&Co.KG.
% You may alter it corresponding to your needs.
% Comments and Corrections are very welcome.
% Please contact us by mailing to support-software@pi.ws. Thank you.

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', sGcsFunctionName];
if(any(strcmp(functionName,c.dllfunctions)))
    if(nargin==2)
        szAxes = '';
    end    
    len = GetNrAxes(c, szAxes);
    if(len == 0)
		return;
    end
    
	dValues = zeros(len,1);
	pdValues = libpointer('doublePtr',dValues);
	try
		[ret,~,dValues] = calllib(c.libalias,functionName,c.ID,szAxes,pdValues);
		if(ret==0)
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
