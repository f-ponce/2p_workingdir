function [Value] = CallGcs_InCharArray_OutUInt32Array_Function(c, sGcsFunctionName,ContainerUnit)
%PI MATLAB Class Library Version 1.6.0
% This code is provided by Physik Instrumente(PI) GmbH&Co.KG.
% You may alter it corresponding to your needs.
% Comments and Corrections are very welcome.
% Please contact us by mailing to support-software@pi.ws. Thank you.
if(c.ID<0), error('The controller is not connected'),end
functionName = [ c.libalias, '_', sGcsFunctionName];
if(any(strcmp(functionName,c.dllfunctions)))
    if(nargin==2)
        ContainerUnit = '';
    end
    Value  = uint32(zeros(100,1)) + intmax('uint32');
	pValue = libpointer('uint32Ptr',Value);
	try
		[bRet,~,Value] = calllib(c.libalias,functionName,c.ID,ContainerUnit,pValue);
        Value = Value(Value~=intmax('uint32'));
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