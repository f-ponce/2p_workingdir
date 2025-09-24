function [sAnswer] = qKLT(c, szStartCoordSystem, szEndCoordSystem)
%   DESCRIPTION
%   Returns the position and orientation of the coordinate system which results from a chain of linked 
%   coordinate systems, or from a part of a chain. The part to be queried can be limited by specifying the start 
%   and end points in the chain.
%
%   SYNTAX
%       [sAnswer] = PIdevice.qKLT(szStartCoordSystem, szEndCoordSystem)
% 
%   INPUT
%       szStartCoordSystem (char array)         name of the coordinate system which is the start point in the chain. Can be ''
%
%       szEndCoordSystem (char array)           name of the coordinate system which is the end point in the chain. Can be ''
%
%   OUTPUT
%       [sAnswer] (char array)                  buffer to receive the string read in from controller, 
%                                               lines are separated by line-feed characters 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (nargin == 1)
    szStartCoordSystem = '';
    szEndCoordSystem = '';
end

[sAnswer] = CallGcs_InNArgs_OutString_Function(c,mfilename,1024,szStartCoordSystem,szEndCoordSystem);

