function [axesOperationModes] = qSAM(c,axisContainerUnit)
%   DESCRIPTION
%   
%   Queries the current operating mode of the axes.
%    
%
%   SYNTAX
%        [axesOperationModes] = PIdevice.qSAM(axisContainerUnit)
% 
%   INPUT
%       axisContainerUnit (char array)               One axis of the control
%
%   OUTPUT
%       [axesOperationModes] (int array)            Operating mode of the axis
%      
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(nargin==1)
    [axesOperationModes] = CallGcs_InCharArray_OutUInt32Array_Function(c,mfilename);
else
    [axesOperationModes] = CallGcs_InCharArray_OutUInt32Array_Function(c,mfilename,axisContainerUnit);
end