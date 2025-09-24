function KCP (c, szSource, szDestination)
%   DESCRIPTION
%   Copies a coordinate system.
%
%   SYNTAX
%       PIdevice.KCP(szSource, szDestination)
% 
%   INPUT
%       szSource (char array)            name of already defined coordinate system
%
%       szDestination (char array)       name of coordinate system copy
%  
%   PI MATLAB Class Library Version 1.5.0    
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
        [bRet] = calllib (c.libalias, functionName, c.ID, szSource, szDestination);
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
