function EnableTCPIPScan(c)
%   DESCRIPTION
%   Selects the network hardware type (e.g. Lantronix XPort or other Ethernet device) which is to be found by 
%   EnumerateTCPIPDevices(). By default, all devices will be found—change the settings only in special 
%   cases and if you know which Ethernet hardware is implemented in your controller.
%
%   SYNTAX
%       PIdevice.EnableTCPIPScan
%  
%   PI MATLAB Class Library Version 1.5.0    
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% only load dll if it wasn't loaded before
if(~libisloaded(c.libalias))
	c = LoadGCSDLL(c);
end
if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID);
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
