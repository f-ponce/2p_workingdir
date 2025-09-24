function [sAnswer] = qSAI_ALL(c)
%   DESCRIPTION
%   Get the identifiers for all axes (configured and unconfigured axes). Each character in the returned string is 
%   an axis identifier for one logical axis. This function is provided for compatibility with controllers which allow 
%   for axis deactivation. qSAI_ALL() then ensures that the answer also includes the axes which are "deactivated".
%
%   SYNTAX
%       [sAnswer] = PIdevice.qSAI_ALL()
%
%   OUTPUT
%       [sAnswer] (char array)              buffer to receive the string read in 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[sAnswer] = CallGcs_InNArgs_OutString_Function(c,mfilename, 1024);
