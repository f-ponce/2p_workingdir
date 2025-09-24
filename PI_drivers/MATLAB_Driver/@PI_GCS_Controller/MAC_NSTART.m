function MAC_NSTART(c,szMacroName,nTimes)
%   DESCRIPTION
%   Start macro with name szMacroName. The macro is repeated nrRuns times.
%   To find out what macros are available call qMAC(). 
%   See "Controller Macros" and the MAC command description in the controller User Manual for details.
%
%   SYNTAX
%       PIdevice.MAC_NSTART(szMacroName,nTimes)
% 
%   INPUT
%       szMacroName (char array)        string with name of the macro to start
%
%       nTimes (int)                    number of runs
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,szMacroName,nTimes);
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
