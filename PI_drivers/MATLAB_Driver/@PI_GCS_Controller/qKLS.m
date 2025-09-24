function [sAnswer] = qKLS (c, szNameOfCoordSystem, szItem1, szItem2)
%   DESCRIPTION
%   Lists properties of all coordinate systems..
%
%   SYNTAX
%       [sAnswer] = PIdevice.qKLS(szNameOfCoordSystem, szItem1, szItem2)
% 
%   INPUT
%       szNameOfCoordSystem (char array)        string with name of the coordinate system. Can be ''
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (nargin == 1)
    szNameOfCoordSystem = '';
    szItem1 = '';
    szItem2 = '';
end

[sAnswer] = CallGcs_InNArgs_OutString_Function(c,mfilename,1024,szNameOfCoordSystem,szItem1,szItem2);
