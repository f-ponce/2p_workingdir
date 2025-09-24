function [szAnswer] = qIFS(c,szAxes)
%   DESCRIPTION
%   Get the interface configuration stored in non-volatile memory (this is the current power-on default).
%
%   SYNTAX
%       [szAnswer] = PIdevice.qIFS(szAxes)
% 
%   INPUT
%       szAxes (char array)         the interface parameters to be queried, can be RSBAUD, GPADR, 
%                                   IPADR, IPSTART, IPMASK and MACADR (depends on the controller)
%
%   OUTPUT
%       [szAnswer] (char array)     buffer to receive the values of the parameters from non-volatile memory
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	szAnswer = blanks(1001);
	if(~exist('szAxes'))
		szAxes = '';
	end
	try
		[bRet,~,szAnswer] = calllib(c.libalias,functionName,c.ID,szAxes,szAnswer,1000);
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
