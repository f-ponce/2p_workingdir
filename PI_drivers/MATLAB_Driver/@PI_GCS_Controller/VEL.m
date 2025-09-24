function VEL(c,szAxes,dValues)
%   DESCRIPTION
%   Set the velocities to use during moves of szAxes. The VEL() setting only takes effect when the given 
%   axis is in closed-loop operation (servo on).
%
%   For controllers with GCS 3.0 syntax:
%       szAxes can only include one axis.
%
%   SYNTAX
%       PIdevice.VEL(szAxes, dValues)
% 
%   INPUT
%       szAxes (char array)             string with axes
%
%       dValues (double array)          velocities for the axes
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CallGcs_InAxes_InDoubleArray_Function(c,mfilename,szAxes,dValues)
