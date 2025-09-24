function [dValues] = qSST(c,szAxes)
%   DESCRIPTION
%   Gets the distance ("step size") for motions of the given axis that are triggered by a manual control unit.
%
%   SYNTAX
%       [dValues] = PIdevice.qSST(szAxes)
% 
%   INPUT
%       szAxes (char array)             axes of the controller
%
%   OUTPUT
%       [dValues] (double array)        array to receive the distance values used for the axes 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    dValues = CallGcs_InAxes_OutDoubleArray_Function(c, mfilename);
else
    dValues = CallGcs_InAxes_OutDoubleArray_Function(c, mfilename, szAxes);
end    
