function [sAnswer] = qHLP(c)
%   DESCRIPTION
%   Read in the help string from the controller. The answer is quite long (up to 3000 characters)
%   so be sure to provide enough space! (And you may have to wait a bit...) 
%
%   SYNTAX
%       [sAnswer] = PIdevice.qHLP()
%
%   OUTPUT
%       [sAnswer] (char array)          buffer to receive the string read in from controller,
%                                       lines are separated by '\n' ("line-feed") 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[sAnswer] = CallGcs_InNArgs_OutString_Function(c,mfilename, 8192);
