function STE(c,szAxes,dValues)
%   DESCRIPTION
%   Starts performing a step and recording the step response for the given axis. 
%
%   SYNTAX
%       PIdevice.STE(szAxes,dValues)
% 
%   INPUT
%       szAxes  (char array)            axes for which the step response will be recorded
%
%       dValues (double)                amplitude of the step
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CallGcs_InAxes_InDoubleArray_Function(c,mfilename,szAxes,dValues)
