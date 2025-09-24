function [dValues] = qVEL(c,szAxes)
%   DESCRIPTION
%   Gets the velocity value commanded with VEL() for szAxes.
%
%   For controllers with GCS 3.0 syntax:
%       szAxes can only include one axis or None for all axes
%
%   SYNTAX
%       [dValues] = PIdevice.qVEL(szAxes)
% 
%   INPUT
%       szAxes (char array)             string with axes
%
%   OUTPUT
%       [dValues] (double array)        array to be filled with the velocity settings of the axes 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    dValues = CallGcs_InAxesOrNone_OutDoubleArray_Function(c, mfilename);
else
    dValues = CallGcs_InAxesOrNone_OutDoubleArray_Function(c, mfilename, szAxes);
end    
