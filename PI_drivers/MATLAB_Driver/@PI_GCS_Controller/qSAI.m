function [sAnswer] = qSAI(c)
%   DESCRIPTION
%   Get the identifiers for all configured axes. Each character in the returned string is an axis identifier for one 
%   logical axis. Deactivated axes are not shown. 
%
%   SYNTAX
%       [sAnswer] = PIdevice.qSAI()
% 
%   OUTPUT
%       [sAnswer] (char array)               buffer to receive the string read in 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[sAnswer] = CallGcs_InNArgs_OutString_Function(c,mfilename, 1024);
