function [dValues] = qCAV(c,szAxes)
%   DESCRIPTION
%   Get the current value of the variable controlled by the selected closed-loop control mode 
%   (see CMO() for selection). 
%
%   SYNTAX
%       [dValues] = PIdevice.qCAV(szAxes)
% 
%   INPUT
%       szAxes (char array)             strings with axes
%
%   OUTPUT
%       [dValues] (double array)        array to be filled with current values of the axes 
%   
%   PI MATLAB Class Library Version 1.5.0   
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    dValues = CallGcs_InAxes_OutDoubleArray_Function(c, mfilename);
else
    dValues = CallGcs_InAxes_OutDoubleArray_Function(c, mfilename, szAxes);
end    

