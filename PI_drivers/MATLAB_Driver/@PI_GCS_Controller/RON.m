function RON(c,szAxes,iValues)
%   DESCRIPTION
%   Sets referencing mode for given axes. Determines how to reference axes measured by incremental sensors.
%
%   SYNTAX
%       PIdevice.(szAxes, iValues)
% 
%   INPUT
%       szAxes (char array)         string with axes
%
%       iValues (int array)         reference modes for the specified axes
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CallGcs_InAxes_InInt32Array_Function(c,mfilename,szAxes,iValues)

