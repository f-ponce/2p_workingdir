function PLM(c,szAxes,dValues)
%   DESCRIPTION
%   Set upper limits ("soft limit") for the positions of szAxes.
%   Depending on the controller, the soft limits are activated and deactivated with SSL().
%
%   SYNTAX
%       PIdevice.PLM(szAxes,dValues)
% 
%   INPUT
%       szAxes (char array)             string with axes
%
%       dValues (double array)          upper limits for position
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CallGcs_InAxes_InDoubleArray_Function(c,mfilename,szAxes,dValues)
