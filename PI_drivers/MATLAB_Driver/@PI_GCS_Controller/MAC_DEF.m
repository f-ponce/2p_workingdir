function MAC_DEF(c,sMacroName)
%   DESCRIPTION
%   Set macro with name szMacroName as start-up macro. This macro will be automatically executed with the 
%   next power-on or reboot of the controller. If szMacroName is omitted, the current start-up macro selection 
%   is canceled. To find out what macros are available call qMAC().
%   See "Controller Macros" and the MAC command description in the controller User Manual for details.
%
%   SYNTAX
%       PIdevice.MAC_DEF(sMacroName)
% 
%   INPUT
%       sMacroName (char array)             name of the macro to be the start-up macro
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,sMacroName);
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
