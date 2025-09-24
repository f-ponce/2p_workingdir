function [dValues] = qSTE(c,szAxes)
%   DESCRIPTION
%   Get last sent amplitude for the step response measurement for given axis (sent with STE()).
%
%   SYNTAX
%       [dValues] = PIdevice.qSTE(szAxes)
% 
%   INPUT
%       szAxes (char array)             axes to be read 
%
%   OUTPUT
%       [dValues] (double array)        array to be filled with the step amplitude values of the axes
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    dValues = CallGcs_InAxes_OutDoubleArray_Function(c, mfilename);
else
    dValues = CallGcs_InAxes_OutDoubleArray_Function(c, mfilename, szAxes);
end    
