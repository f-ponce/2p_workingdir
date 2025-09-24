function BRA(c,szAxes,iValues)
%   DESCRIPTION
%   Set brake for szAxes on (1) or off (0)
%
%   SYNTAX
%       PIdevice.BRA(szAxes, iValues)
% 
%   INPUT
%       szAxes (char array)         string with axes
%
%       iValues (int array)         modes for the specified axes
%                                   1 for on
%                                   0 for off
% 
%   PI MATLAB Class Library Version 1.5.0     
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CallGcs_InAxes_InInt32Array_Function(c,mfilename,szAxes,iValues)
