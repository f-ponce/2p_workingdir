function [sAnswer] = qIDN(c)
%   DESCRIPTION
%   Get identification string of the controller
%
%   SYNTAX
%       [sAnswer] = PIdevice.qIDN()
%
%   OUTPUT
%       [sAnswer] (char array)      identification string of the controller
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[sAnswer] = CallGcs_InNArgs_OutString_Function(c,mfilename, 1024);
