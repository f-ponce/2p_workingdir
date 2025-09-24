function [dValues] = qCCV(c,szAxes)
%   DESCRIPTION
%   Get currently valid control value.
%   qCCV() queries the control value in open-loop and closed-loop operation.
%
%   SYNTAX
%       [dValues] = PIdevice.qCCV(szAxes)
% 
%   INPUT
%       szAxes (char array)         string with Axes
%
%   OUTPUT
%       [dValues] (double array)    array to be filled with current control values of the axes 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    dValues = CallGcs_InAxes_OutDoubleArray_Function(c, mfilename);
else
    dValues = CallGcs_InAxes_OutDoubleArray_Function(c, mfilename, szAxes);
end    
