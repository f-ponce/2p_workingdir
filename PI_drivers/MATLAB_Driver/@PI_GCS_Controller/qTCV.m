function [dValues] = qTCV(c,szAxes)
%   DESCRIPTION
%   Gets the current value of the velocity for closed-loop operation (value calculated by the profile generator).
%
%   SYNTAX
%       [dValues] = PIdevice.qTCV(szAxes)
% 
%   INPUT
%       szAxes (char array)             string with axes
%
%   OUTPUT
%       [dValues] (double array)        array to be filled with the current velocity
%                                       values calculated by the profile generator
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    dValues = CallGcs_InAxes_OutDoubleArray_Function(c, mfilename);
else
    dValues = CallGcs_InAxes_OutDoubleArray_Function(c, mfilename, szAxes);
end    
