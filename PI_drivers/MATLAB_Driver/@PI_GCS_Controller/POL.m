function POL(c,szAxes,iValues)
%   DESCRIPTION
%   Set the axis to either 0 % or 100 % of its travel range. It does not use the actuator’s previous 
%   history but instead, the maximum number of pulses / maximum duration of pulses.
%
%   SYNTAX
%       PIdevice.POL(szAxes,iValues)
% 
%   INPUT
%       szAxes (char array)             string with axes 
%
%       iValues (int array)             set axis travel range, 1 for "100%", 0 for "0%"
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CallGcs_InAxes_InInt32Array_Function(c,mfilename,szAxes,iValues)

