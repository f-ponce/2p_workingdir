function DCO(c,szAxes,iValues)
%   DESCRIPTION
%   Sets drift compensation mode for given axes (on or off). Drift compensation is applied to avoid unwanted 
%   changes in displacement over time and is therefore recommended for static operation. For a detailed 
%   description see "Drift Compensation" in the controller User Manual.
%   Drift compensation is automatically deactivated as long as the wave generator is activated.
%
%   SYNTAX
%       PIdevice.DCO(szAxes,iValues)
% 
%   INPUT
%       szAxes (char array)             string with axes 
%
%       iValues (int)                   gives the drift compensation mode, can have the following values:
%                                       0 = drift compensation off
%                                       1 = drift compensation on
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CallGcs_InAxes_InInt32Array_Function(c,mfilename,szAxes,iValues)
