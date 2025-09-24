function KEN(c,szCoordinateSystemName)
%   DESCRIPTION
%   Enables an already defined coordinate system.
%
%   SYNTAX
%       PIdevice.KEN(szCoordinateSystemName)
% 
%   INPUT
%       szCoordinateSystemName (char array)     name of the coordinate system to be enabled
%     
%   PI MATLAB Class Library Version 1.5.0 
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias, functionName, c.ID, szCoordinateSystemName);
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
