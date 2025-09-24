function VCO(c,szAxes,iValues)
%   DESCRIPTION
%   Set velocity-control "on" or "off". When velocity-control is "on", the corresponding axes will move 
%   with the currently valid velocity. That velocity can be set with VEL(). 
%
%   SYNTAX
%       PIdevice.VCO(szAxes,iValues)
% 
%   INPUT
%       szAxes (char array)             string with axes 
%
%       iValues (int array)             modes for the specified axes, 
%                                       1 for "on", 0 for "off" 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CallGcs_InAxes_InInt32Array_Function(c,mfilename,szAxes,iValues)
