function MVR(c,szAxes,dValues)
%   DESCRIPTION
%   Move szAxes relative to current target position. The new target position is calculated by adding the given 
%   position value to the last commanded target value. Axes will start moving to the new position if ALL given 
%   targets are within the allowed range and ALL axes can move. All axes start moving simultaneously. Servo 
%   must be enabled for all commanded axes prior to using this command.
%
%   SYNTAX
%       PIdevice.MVR(szAxes,dValues)
% 
%   INPUT
%       szAxes (char array)           string with axes
%
%       dValues (double array)        amounts to be added (algebraically) to current target positions of the axes 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CallGcs_InAxes_InDoubleArray_Function(c,mfilename,szAxes,dValues)
