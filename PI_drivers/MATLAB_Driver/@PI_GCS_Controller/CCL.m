function CCL(c, intComandLevel, szPassWord)
%   DESCRIPTION
%   If Password is correct, this function sets the CommandLevel of the 
%   controller and determines thus the availability of commands and the  
%   write access to the system parameters. Use qHLP to determine which
%   commands are available in the current command level. qHPA lists the
%   parameters including the information about which command level allows
%   write access to them.
%
%   SYNTAX
%       PIdevice.CCL(iCommandLevel, szPassWord)
% 
%   INPUT
%       iCommandLevel (int)           0 = the default setting, all commands provided for "normal" 
%                                         users are available, read access to all parameters
%                                     1 = provides additional commands and write access to level-1-parameters
%                                         (commands and parameters from level 0 are included).
%
%       szPassword (char array)       password for CCL 1 is “ADVANCED”, for CCL 0 no password is required
%  
%   PI MATLAB Class Library Version 1.5.0    
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
        [bRet] = calllib(c.libalias, functionName, c.ID, intComandLevel, szPassWord);
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
    