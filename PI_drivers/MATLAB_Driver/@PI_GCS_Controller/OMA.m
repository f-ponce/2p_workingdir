function OMA(c,szAxes,dValues)
%   DESCRIPTION
%   Commands szAxes to the given absolute position. Motion is realized in open-loop nanostepping mode.
%   Servo must be disabled for the commanded axis prior to using this function (open-loop operation).
%   With OMA() there is no position control (i.e. the target position is not maintained by any control loop).
%
%   SYNTAX
%       PIdevice.OMA(szAxes,dValues)
% 
%   INPUT
%       szAxes (char array)                 string with axes
%
%       dValues (double array)              target positions for the axes 
% 
%   PI MATLAB Class Library Version 1.5.0     
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CallGcs_InAxes_InDoubleArray_Function(c,mfilename,szAxes,dValues)
