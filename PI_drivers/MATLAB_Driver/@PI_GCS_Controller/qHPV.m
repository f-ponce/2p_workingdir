function [sAnswer] = qHPV(c)
%   DESCRIPTION
%   Responds with a help string which contains possible  parameters values. Use PI_qHPA instead to get a 
%   help string which contains all available parameters with short descriptions.
%
%   SYNTAX
%       [sAnswer] = PIdevice.qHPV() 
%
%   OUTPUT
%       [sAnswer] (char array)      buffer to receive the string read in from controller,
%                                   lines are separated by '\n' ("line-feed").
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[sAnswer] = CallGcs_InNArgs_OutString_Function(c,mfilename, 8192);
