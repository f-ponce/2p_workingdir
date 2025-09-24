function [sAnswer] = qHPA(c)
%   DESCRIPTION
%   Lists a help string which contains all available parameters with short descriptions. See the user manual of 
%   the controller for an appropriate list of all parameters available for your controller.
%
%   SYNTAX
%       [sAnswer] = PIdevice.qHPA()
%
%   OUTPUT
%       [sAnswer] (char array)          buffer to receive the string read in from controller,
%                                       lines are separated by '\n' ("line-feed") 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[sAnswer] = CallGcs_InNArgs_OutString_Function(c,mfilename, 8192);
