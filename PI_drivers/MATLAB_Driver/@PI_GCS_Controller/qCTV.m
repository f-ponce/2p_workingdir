function dValues = qCTV(c,szAxes)
%   DESCRIPTION
%   Get the currently valid closed-loop target for szAxes. The physical unit and hence the interpretation of the 
%   value depend on the closed-loop control mode which is selected for the axis (see CMO() for selection).
%   Use qCAV() to get the current value of the controlled variable.
%
%   SYNTAX
%       dValues = PIdevice.qCTV(szAxes)
% 
%   INPUT
%       szAxes (char array)             string with axes
%
%   OUTPUT
%       dValues (double array)          array to be filled with target values of the axes 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    dValues = CallGcs_InAxes_OutDoubleArray_Function(c, mfilename);
else
    dValues = CallGcs_InAxes_OutDoubleArray_Function(c, mfilename, szAxes);
end    
