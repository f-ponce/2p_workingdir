function Destroy( c )
%   DESCRIPTION
%   DESTROY Controller object and unload library
%
%   SYNTAX
%       Controller.Destroy()
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(IsConnected(c))
    c = CloseConnection(c);
end
UnloadGCSDLL(c);
clear c;