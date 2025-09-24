function [sAnswer] = qKET(c, szTypes)
%   DESCRIPTION
%   Lists enabled coordinate systems by name.
%
%   SYNTAX
%       [sAnswer] = PIDevice.qKET(szTypes)
% 
%   INPUT
%       szTypes (char array)        string with name of the coordinate system. Can be '' to return all
%
%   OUTPUT
%       [sAnswer] (char array)      buffer to receive the string read in from controller, 
%                                   lines are separated by line-feed characters 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[sAnswer] = CallGcs_InNArgs_OutString_Function(c,mfilename,1024,szTypes);
