function c = CloseConnection(c)
%   DESCRIPTION
%   Close connection to the controller
%
%   SYNTAX
%       PIdevice.CloseConnection()
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functionName = [ c.libalias, '_', mfilename];
if(strmatch(functionName,c.dllfunctions))
    calllib(c.libalias,functionName,c.ID);
    c = SetDefaults(c);
else
    error(sprintf('%s not found',functionName));
end