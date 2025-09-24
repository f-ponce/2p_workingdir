function [commandedSteps] = qSMV(c,axisContainerUnit)
%   DESCRIPTION
%   
%   Queries the commanded number and direction of steps for the axes.
%    
%
%   SYNTAX
%        [commandedSteps] = PIdevice.qSMV(axisContainerUnit)
% 
%   INPUT
%       axisContainerUnit (char array)           One axis of the control
%
%   OUTPUT
%       [commandedSteps] (int array)             The currently commanded number and the direction of the steps to be taken
%      
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    commandedSteps = CallGcs_InAxesOrNone_OutDoubleArray_Function(c, mfilename);
else
    commandedSteps = CallGcs_InAxesOrNone_OutDoubleArray_Function(c, mfilename, axisContainerUnit);
end  