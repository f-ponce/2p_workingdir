function MOV(c,szAxes,dValues)
%   DESCRIPTION
%   Move szAxes to specified absolute positions. Axes will start moving to the new positions if ALL given 
%   targets are within the allowed ranges and ALL axes can move. All axes start moving simultaneously. 
%   Servo must be enabled for all commanded axes prior to using this command.
%
%   SYNTAX
%       PIDevice.MOV(szAxes,dValues)
% 
%   INPUT
%       szAxes (char array)             string with axes
%
%       dValues (double array)          target positions for the axes
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CallGcs_InAxes_InDoubleArray_Function(c,mfilename,szAxes,dValues)

