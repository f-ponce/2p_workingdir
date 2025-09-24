function CMO(c,szAxes,iValues)
%   DESCRIPTION
%   Select closed-loop control mode. The selection determines the controlled variable 
%   (e.g. position or velocity or force). The currently valid target value for the 
%   controlled variable can be queried with qCTV(). An absolute target for the controlled 
%   variable can be set with CTV(), a relative target can be set with CTR(). The current 
%   value of the controlled variable can be queried with qCAV().
%
%   SYNTAX
%       PIdevice.CMO(szAxes, iValues)
% 
%   INPUT
%       szAxes (char array)     string with axes
%
%       iValues (int)           modes for the specific axes
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CallGcs_InAxes_InInt32Array_Function(c,mfilename,szAxes,iValues)

