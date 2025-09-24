function NLM(c,szAxes,dValues)
%   DESCRIPTION
%   Set lower limits ("soft limit") for the positions of szAxes. 
%   Depending on the controller, the soft limits are activated and deactivated with SSL().
%
%   SYNTAX
%       PIdevice.NLM(szAxes, dValues)
% 
%   INPUT
%       szAxes (char array)             string with axes
%
%       dValues (double array)          lower limits for position
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CallGcs_InAxes_InDoubleArray_Function(c,mfilename,szAxes,dValues)
