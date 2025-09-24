function [iValues] = IsMoving(c,szAxes)
%   DESCRIPTION
%   Check if szAxes are moving. If an axis is moving the corresponding element of the array will be TRUE, 
%   otherwise FALSE. If no axes were specified, only one boolean value is returned and iValues will 
%   contain a generalized state: TRUE if at least one axis is moving, FALSE if no axis is moving.
%
%   SYNTAX
%       [iValues] = PIdevice.IsMoving(szAxes)
% 
%   INPUT
%       szAxes (char array)             string with axes, if no parameters were passed, all axes are affected. 
%
%   OUTPUT
%       [iValues] (int array)           array to receive the status of the axes 
%     
%   PI MATLAB Class Library Version 1.5.0 
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    iValues = CallGcs_InAxes_OutInt32Array_Function(c, mfilename);
else
    iValues = CallGcs_InAxes_OutInt32Array_Function(c, mfilename, szAxes);
end    
