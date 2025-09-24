function SetErrorCheck(c,iValues1)
%   DESCRIPTION
%   Set error-check mode of the library. With this call you can specify whether the library should check the 
%   error state of the controller (with "ERR?") after sending a command. This will slow down communications, 
%   so if you need a high data rate, switch off error checking and call GetError() yourself when there is 
%   time to do so. You might want to use permanent error checking to debug your application and switch it off 
%   for normal operation.  At startup of the library error checking is switched on.
%
%   SYNTAX
%       PIDevice.SetErrorCheck(iValues1)
% 
%   INPUT
%       iValues1 (int)                          switch error checking on (1) or off (0)  
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,iValues1);
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
