function CTV(c,szAxes,dValues)
%   DESCRIPTION
%   Set absolute closed-loop target for szAxes. Moves the given axes. All axes start moving simultaneously.
%   Servo must be enabled for all commanded axes prior to using this command. The selected closed-loop 
%   control mode (see CMO()) determines the variable which is controlled with 
%   CTV() (e.g. position or velocity or force).
%
%   SYNTAX
%       PIdevice.CTV(szAxes,dValues)
% 
%   INPUT
%       szAxes  (char array)            string with axes
%
%       dValues (double array)          target values for the axes
%     
%   PI MATLAB Class Library Version 1.5.0 
%   COPYRIGHT � PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CallGcs_InAxes_InDoubleArray_Function(c,mfilename,szAxes,dValues)
