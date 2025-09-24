function GcsCommandset(c,szAxes)
%   DESCRIPTION
%   Sends a GCS command to the controller. Any GCS command can be sent, but this command is intended 
%   to allow use of commands not having a function in the current version of the library.
%   See the User Manual of the controller for a description of the GCS commands which are understood by 
%   the controller firmware, for a command reference and for any limitations regarding the arguments of the 
%   commands.
%
%   SYNTAX
%       PIdevice.GcsCommandset(szAxes)
% 
%   INPUT
%       szAxes (char array)             the GCS command as string
%    
%   PI MATLAB Class Library Version 1.5.0  
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,szAxes);
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
