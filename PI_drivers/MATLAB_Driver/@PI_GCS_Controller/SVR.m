function SVR(c,szAxes,dValues)
%   DESCRIPTION
%   Set open-loop control value relative to the current open-loop control value to move szAxes.
%   The new open-loop control value is calculated by adding the given value to the last commanded open-loop 
%   control value. 
%   Servo must be switched off when using this command (open-loop operation).
%
%   SYNTAX
%       PIdevice.SVR(szAxes,dValues)
% 
%   INPUT
%       szAxes (char array)             string with axes 
%
%       dValues (double array)          the open-loop control values which are added to the current values
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CallGcs_InAxes_InDoubleArray_Function(c,mfilename,szAxes,dValues)

