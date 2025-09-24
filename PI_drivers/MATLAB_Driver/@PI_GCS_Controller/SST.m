function SST(c,szAxes,dValues)
%   DESCRIPTION
%   Sets the distance ("step size") for motions of the given axis that are triggered by a manual control unit.
%
%   SYNTAX
%       PIdevice.SST(szAxes,dValues)
% 
%   INPUT
%       szAxes  (char array)                axes of the controller
%
%       dValues (double array)              value array of the distance values
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CallGcs_InAxes_InDoubleArray_Function(c,mfilename,szAxes,dValues)
