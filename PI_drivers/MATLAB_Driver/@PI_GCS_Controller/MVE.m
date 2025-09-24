function MVE(c,szAxes,dValues)
%   DESCRIPTION
%   Set new absolute target positions for given axes. Axes will start moving to the new positions if ALL given 
%   targets are within the allowed range and ALL axes can move.
%   If the affected axes are mounted in a way that they move perpendicular to each other, the combined 
%   motion of them will describe a linear path. This is achieved by appropriate calculation of accelerations, 
%   velocities and decelerations. The current settings for velocity, acceleration and deceleration define the 
%   maximum possible values, and the slowest axis determines the resulting velocities.
%   All axes start moving simultaneously.
%   This command can be interrupted by STP() and HLT(). No other motion commands (e.g. 
%   MOV(), MVR()) are allowed during vector move.
%   Servo must be enabled for all commanded axes prior to using this command. If servo is switched off or
%   motion error occurs during motion, all axes are stopped.
% 
%   SYNTAX
%       PIdevice.MVE(szAxes, dValues)
% 
%   INPUT
%       szAxes (char array)                     string with axes
%
%       dValues (double array)                  target positions for the axes 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CallGcs_InAxes_InDoubleArray_Function(c,mfilename,szAxes,dValues)

