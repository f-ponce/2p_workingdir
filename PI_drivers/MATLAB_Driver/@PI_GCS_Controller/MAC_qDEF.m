function [sDefaultMacroName] = MAC_qDEF(c)
%   DESCRIPTION
%   Ask for the start-up macro.
%   See "Controller Macros" and the MAC command description in the controller User Manual for details.
%
%   SYNTAX
%       [sDefaultMacroName] = PIdevice.MAC_qDEF
% 
%   OUTPUT
%       [sDefaultMacroName] (char array)            buffer to receive the string read in from controller, 
%                                                   contains the name of the start-up macro. 
%                                                   If no start-up macro is defined, the response is an
%                                                   empty string with the terminating character.
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    iMaxBufferSize = 1024;
    sDefaultMacroNameBuffer = blanks(iMaxBufferSize + 1);    
	try
		[bRet,sDefaultMacroName] = calllib(c.libalias,functionName,c.ID,sDefaultMacroNameBuffer,iMaxBufferSize);
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
