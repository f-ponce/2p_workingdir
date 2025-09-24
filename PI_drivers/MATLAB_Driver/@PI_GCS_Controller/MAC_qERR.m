function [sError] = MAC_qERR(c)
%   DESCRIPTION
%   Reports the last error which occurred during macro execution.
%   See "Controller Macros" and the MAC command description in the controller User Manual for details.
%
%   SYNTAX
%       [sError] = PIdevice.MAC_qERR
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    iBufferSize = 1024;
    sErrorBuffer = blanks(iBufferSize);
	try
		[bRet,sError] = calllib(c.libalias,functionName,c.ID,sErrorBuffer,iBufferSize);
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
