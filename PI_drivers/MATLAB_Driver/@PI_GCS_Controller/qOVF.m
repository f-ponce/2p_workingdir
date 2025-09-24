function [iValues] = qOVF(c,szAxes)
%   DESCRIPTION
%   Checks overflow status of szAxes. Overflow means that the control variables are out of range 
%   (can only happen if controller is in closed-loop mode).
%
%   SYNTAX
%       [iValues] = PIdevice.qOVF(szAxes)
% 
%   INPUT
%       szAxes (char array)             string with axes
%
%   OUTPUT
%       [iValues] (int array)           array to be filled with current overflow status of the axes
%                                       ("0" = axis is not in overflow or "1" = axis is in overflow)
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    iValues = CallGcs_InAxes_OutInt32Array_Function(c, mfilename);
else
    iValues = CallGcs_InAxes_OutInt32Array_Function(c, mfilename, szAxes);
end    
