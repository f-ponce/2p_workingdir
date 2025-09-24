function SVA(c,szAxes,dValues)
%   DESCRIPTION
%   Set absolute open-loop control value to move szAxes.
%   Servo must be switched off (open-loop operation) when using this command.
%
%   SYNTAX
%       PIdevice.SVA(szAxes,dValues)
% 
%   INPUT
%       szAxes (char array)             string with axes 
%
%       dValues (double array)          absolute open-loop control value 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CallGcs_InAxes_InDoubleArray_Function(c,mfilename,szAxes,dValues)
