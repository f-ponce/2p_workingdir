function [remainingSteps] = qSMR(c,axisContainerUnit)
%   DESCRIPTION
%   
%   Queries the current number and direction of the steps still to be taken for the axes.
%    
%
%   SYNTAX
%        [remainingSteps] = PIdevice.qSMR(axisContainerUnit)
% 
%   INPUT
%       axisContainerUnit (char array)           One axis of the control
%
%   OUTPUT
%       [remainingSteps] (int array)             The current number and direction of the steps still to be taken
%      
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    remainingSteps = CallGcs_InAxesOrNone_OutDoubleArray_Function(c, mfilename);
else
    remainingSteps = CallGcs_InAxesOrNone_OutDoubleArray_Function(c, mfilename, axisContainerUnit);
end  