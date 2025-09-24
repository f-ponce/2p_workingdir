function [controlValue] = qOCV(c,axisContainerUnit)
%   DESCRIPTION
%   
%   Gets the open loop control value for the axis.
%    
%
%   SYNTAX
%        [controlValue] = PIdevice.qOCV(axisContainerUnit)
% 
%   INPUT
%       axisContainerUnit (char array)          One axis of the control
%
%   OUTPUT
%       [controlValue] (int array)              The current open loop control value
%      
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    controlValue = CallGcs_InAxesOrNone_OutDoubleArray_Function(c, mfilename);
else
    controlValue = CallGcs_InAxesOrNone_OutDoubleArray_Function(c, mfilename, axisContainerUnit);
end  