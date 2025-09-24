function UCL(c,userCommandLevel,password)
%   DESCRIPTION
%   
%   Changes the user command level.
%   
%
%   SYNTAX
%        PIdevice.UCL(userCommandLevel,password)
% 
%   INPUT
%       userCommandLevel (char array)           The ID for the command level to change to
%
%       password (char array)                   The password of the command level
% 
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end
userCommandLevel = ConvertCellArrayStringToString (userCommandLevel);
password = ConvertCellArrayStringToString (password);
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,userCommandLevel,password);
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