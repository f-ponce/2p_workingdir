function MAC_NSTART_Args(c,szMacroName,nRuns,szArgs)
%   DESCRIPTION
%   Start macro with name szMacroName. The macro is repeated nrRuns times. Another execution is started 
%   when the last one is finished.
%   szArgs stands for the value of a local variable contained in the macro. The sequence of the values in the 
%   input must correspond to the numbering of the appropriate local variables, starting with the value of the 
%   local variable 1. The individual values must be separated from each other with spaces. A maximum of 256 
%   characters are permitted per function line. szArgs can be given directly or via the value of another variable. 
%   To find out what macros are available call qMAC(). 
%   See "Controller Macros" and the MAC command description in the controller User Manual for details.
%
%   SYNTAX
%       PIdevice.MAC_NSTART_Args(szMacroName,nRuns,szArgs)
% 
%   INPUT
%       szMacroName (char array)            string with name of the macro to start 
%
%       nRuns (int)                         number of runs
%
%       szArgs (char array)                 value of a local variable contained in the macro
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,szMacroName,nRuns,szArgs);
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
