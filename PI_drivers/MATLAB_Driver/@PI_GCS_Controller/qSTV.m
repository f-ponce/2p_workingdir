function [statusArray] = qSTV(c,containerUnit)
%   DESCRIPTION
%   
%   Reads out the status register of a container unit.
%   
%
%   SYNTAX
%        [statusArray] = PIdevice.qSTV(containerUnit)
% 
%   INPUT
%       containerUnit (char array)              Container unit whose status register is to be queried
%
%   OUTPUT
%       [statusArray] (int array)               The status of the container unit
%      
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(nargin==1)
    [statusArray] = CallGcs_InCharArray_OutUInt32Array_Function(c,mfilename);
else
    [statusArray] = CallGcs_InCharArray_OutUInt32Array_Function(c,mfilename,containerUnit);
end