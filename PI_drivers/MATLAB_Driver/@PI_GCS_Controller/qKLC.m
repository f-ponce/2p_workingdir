function [sAnswer] = qKLC (c, szNameOfCoordSystem, szNameOfCoordSystem2, szItem1, szItem2)
%   DESCRIPTION
%   Lists properties of combinations of Work and Tool coordinate systems.
%
%   SYNTAX
%       [sAnswer] = PIdevice.qKLC(szNameOfCoordSystem, szNameOfCoordSystem2, szItem1, szItem2)
% 
%   INPUT
%       szNameOfCoordSystem (char array)        string with name of the coordinate system. Can be ''
%
%       szNameOfCoordSystem2 (char array)       string with name of the coordinate system. Can be ''
%
%       szItem1 (char array)                    string with first item to query. Can be ''
%
%       szItem2 (char array)                    string with second item to query. Can be ''
%
%   OUTPUT
%       [sAnswer] (char array)                  buffer to receive the string read in from controller,
%                                               lines are separated by line-feed characters 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (nargin == 1)
    szNameOfCoordSystem = '';
    szNameOfCoordSystem2 = '';
    szItem1 = '';
    szItem2 = '';
end

[sAnswer] = CallGcs_InNArgs_OutString_Function(c,mfilename,1024,szNameOfCoordSystem, szNameOfCoordSystem2, szItem1, szItem2);
