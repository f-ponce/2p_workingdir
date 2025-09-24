function [dValues] = qOMA(c,szAxes)
%   DESCRIPTION
%   Reads last commanded open-loop target pdValueArray of given szAxes.
%
%   SYNTAX
%       [dValues] = PIdevice.qOMA(szAxes)
% 
%   INPUT
%       szAxes (char array)             string with axes
%
%   OUTPUT
%       [dValues] (double array)        array to be filled with target positions of the axes 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    dValues = CallGcs_InAxes_OutDoubleArray_Function(c, mfilename);
else
    dValues = CallGcs_InAxes_OutDoubleArray_Function(c, mfilename, szAxes);
end    
