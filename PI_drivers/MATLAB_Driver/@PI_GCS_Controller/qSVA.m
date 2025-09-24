function [dValues] = qSVA(c,szAxes)
%   DESCRIPTION
%   Returns last valid open-loop control value for szAxes. 
%
%   SYNTAX
%       [dValues] = PIdevice.qSVA(szAxes)
% 
%   INPUT
%       szAxes (char array)         string with axes
%
%   OUTPUT
%       [dValues] (double array)    array to be filled with the last commanded open-loop control values (dimensionless). 
%                                   The interpretation of the open-loop control values depends on the controller.
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    dValues = CallGcs_InAxes_OutDoubleArray_Function(c, mfilename);
else
    dValues = CallGcs_InAxes_OutDoubleArray_Function(c, mfilename, szAxes);
end    
