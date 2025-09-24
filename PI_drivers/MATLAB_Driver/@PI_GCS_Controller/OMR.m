function OMR(c,szAxes,dValues)
%   DESCRIPTION
%   Commands szAxes to a position relative to the last commanded open-loop target position. The new open-
%   loop target position is calculated by adding the given value pdValueArray to the last commanded target 
%   value. Motion is realized in nanostepping mode. Servo must be disabled for the commanded axis prior to 
%   using this function (open-loop operation). With OMR there is no position control (i.e. the target position 
%   is not maintained by a control loop).
%
%   SYNTAX
%       PIdevice.OMR(szAxes, dValues)
% 
%   INPUT
%       szAxes (char array)             string with axes
%
%       dValues (double array)          target positions for the axes 
%
%   PI MATLAB Class Library Version 1.5.0      
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CallGcs_InAxes_InDoubleArray_Function(c,mfilename,szAxes,dValues)
