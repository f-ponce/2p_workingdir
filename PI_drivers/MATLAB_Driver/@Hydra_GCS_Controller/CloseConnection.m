function c = CloseConnection (c)
% function bRet = MOV(c,szAxes,dValues)
%PI MATLAB Class Library Version 1.1.1
% This code is provided by Physik Instrumente(PI) GmbH&Co.KG.
% You may alter it corresponding to your needs.
% Comments and Corrections are very welcome.
% Please contact us by mailing to c.wurm@pi.ws. Thank you.

if(c.ID<0), error('The controller is not connected'),end;
FunctionName = 'Hydra_CloseConnection';
if(any(strcmp(FunctionName,c.dllfunctions)))
		calllib(c.libalias,FunctionName,c.ID);
        c = SetDefaults(c);
else
	error('%s not found',FunctionName);
end