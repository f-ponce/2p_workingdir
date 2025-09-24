function SPI(c,szAxes,dValues)
%   DESCRIPTION
%   Sets the pivot point coordinates in the volatile memory.
%
%   SYNTAX
%       PIdevice.SPI(szAxes,dValues)
% 
%   INPUT
%       szAxes (char array)         can be R, S and T. X, Y and Z can also be 
%                                   used as alias identifiers for R, S and T
%
%       dValues (double array)      value array of the pivot point coordinates
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CallGcs_InAxes_InDoubleArray_Function(c,mfilename,szAxes,dValues)
