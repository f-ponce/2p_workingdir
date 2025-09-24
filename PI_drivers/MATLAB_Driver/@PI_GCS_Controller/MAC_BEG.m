function MAC_BEG(c,sMacroName)
%   DESCRIPTION
%   Put the DLL in macro recording mode. This function sets a flag in the library and effects the operation of 
%   other functions. Function will fail if already in recording mode. If successful, the commands that follow 
%   become part of the macro, so do not check error state unless FALSE is returned. End the recording with 
%   MAC_END().
%   See "Controller Macros" and the MAC command description in the controller User Manual for details.
%
%   SYNTAX
%       PIdevice.MAC_BEG(sMacroName)
% 
%   INPUT
%       sMacroName (char array)                 name under which macro will be stored in the controller 
%     
%   PI MATLAB Class Library Version 1.5.0 
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
