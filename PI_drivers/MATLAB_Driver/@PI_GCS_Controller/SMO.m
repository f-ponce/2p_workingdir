function SMO(c,szAxes,iValues)
%   DESCRIPTION
%   Sets control value directly to move the axis. Profile generator (if present), sensor feedback and servo 
%   algorithm are not taken into account. This is only possible if servo-control is OFF (see SVO()).
%   NOTICE: In the case of large control values, the positioner can strike the hard stop despite the limit switch 
%   function. This can cause damage to equipment.
%
%   SYNTAX
%       PIdevice.SMO(szAxes,iValues)
% 
%   INPUT
%       szAxes (char array)             string with axes
%
%       iValues (int array)             array with control values.
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CallGcs_InAxes_InInt32Array_Function(c,mfilename,szAxes,iValues)
