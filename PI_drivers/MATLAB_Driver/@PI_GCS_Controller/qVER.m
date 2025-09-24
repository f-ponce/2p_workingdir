function [sAnswer] = qVER(c)
%   DESCRIPTION
%   Reports the versions of the controller firmware and the underlying drivers and libraries.
%
%   SYNTAX
%       [sAnswer] = PIdevice.qVER()
%
%   OUTPUT
%       [sAnswer] (char array)          buffer for storing the string read in 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[sAnswer] = CallGcs_InNArgs_OutString_Function(c,mfilename, 1024);
