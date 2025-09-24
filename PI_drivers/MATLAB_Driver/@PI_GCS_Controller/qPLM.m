function [dValues] = qPLM(c,szAxes)
%   DESCRIPTION
%   Get upper limits ("soft limit") for the positions of szAxes.
%
%   SYNTAX
%       [dValues] = PIdevice.qPLM(szAxes)
% 
%   INPUT
%       szAxes (char array)             string with axes 
%
%   OUTPUT
%       [dValues] (double array)        array to be filled with upper limits for position of the axes. 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    dValues = CallGcs_InAxes_OutDoubleArray_Function(c, mfilename);
else
    dValues = CallGcs_InAxes_OutDoubleArray_Function(c, mfilename, szAxes);
end    
