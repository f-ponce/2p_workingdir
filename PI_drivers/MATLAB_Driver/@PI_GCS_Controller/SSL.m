function SSL(c,szAxes,iValues)
%   DESCRIPTION
%   Activates or deactivates the soft limits that are set with NLM() and PLM(). Soft limits can only be 
%   activated/deactivated when the axis is not moving (query with IsMoving()).
%
%   SYNTAX
%       PIdevice.SSL(szAxes,iValues)
% 
%   INPUT
%       szAxes (char array)             axes of the controller
%
%       iValues (int array)             array with the states of the soft limits:
%                                         0 = soft limits deactivated
%                                         1 = soft limits activated
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CallGcs_InAxes_InInt32Array_Function(c,mfilename,szAxes,iValues)

