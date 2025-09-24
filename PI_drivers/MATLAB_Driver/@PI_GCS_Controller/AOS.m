function AOS(c,szAxes,dValues)
%   DESCRIPTION
%   Set an offset to the analog input for the given axis.
%
%   SYNTAX
%       PIdevice.AOS(szAxes, dValues)
% 
%   INPUT
%       szAxes (char array)         string with axis identifier
%
%       dValues (double array)      analog offset for the axes
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CallGcs_InAxes_InDoubleArray_Function(c,mfilename,szAxes,dValues)
