function [sAnswer] = qTVI(c)
%   DESCRIPTION
%   Get valid characters for axes. Each character in the returned string is a 
%   valid axis identifier that can be used to "name" an axis with SAI(). 
%
%   SYNTAX
%       [sAnswer] = PIdevice.qTVI()
%
%   OUTPUT
%       [sAnswer] (char array)          buffer to store the read in string 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[sAnswer] = CallGcs_InNArgs_OutString_Function(c,mfilename, 1024);
