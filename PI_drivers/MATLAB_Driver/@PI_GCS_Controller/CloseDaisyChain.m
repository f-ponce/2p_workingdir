function c = CloseDaisyChain(c)
%   DESCRIPTION
%   Close connection to the daisy chain port. Note that if there are still 
%   some open connections to one or more daisy chain devices, these 
%   connections will be closed automatically.
%
%   SYNTAX
%       PIdevice.CloseDaisyChain()
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.DC_ID<0), error('The daisy chain is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		calllib(c.libalias,functionName,c.DC_ID);
		c = SetDefaults(c);
	catch
		rethrow(lasterror);
	end
else
	error('%s not found',functionName);
end
c.DC_ID = -1;
c.ConnectedDaisyChainDevices = '';
