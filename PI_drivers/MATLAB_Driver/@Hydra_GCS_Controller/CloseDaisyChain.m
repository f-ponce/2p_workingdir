function c = CloseDaisyChain(c)
%function CloseDaisyChain(c)
%PI MATLAB Class Library Version 1.1.1
% This code is provided by Physik Instrumente(PI) GmbH&Co.KG.
% You may alter it corresponding to your needs.
% Comments and Corrections are very welcome.
% Please contact us by mailing to c.wurm@pi.ws. Thank you.

if(c.DC_ID<0), error('The daisy chain is not connected'),end;
FunctionName = 'PI_CloseDaisyChain';
if(any(strcmp(FunctionName,c.dllfunctions)))
	try
		calllib(c.libalias,FunctionName,c.DC_ID);
		c = SetDefaults(c);
	catch
		rethrow(lasterror);
	end
else
	error('%s not found',FunctionName);
end
c.DC_ID = -1;
