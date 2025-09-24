function EAX(c,szAxes,iValues)
%   DESCRIPTION
%   Enable axis. 
%   
%   For controllers with GCS 2.0 syntax:
%        If disabled, no motion is executed. If motion is commanded for an 
%        axis that is not enabled, an error will be set.
%   
%   For controllers with GCS 3.0 syntax:
%       Switches the drive state machine from "Ready to switch on" to "Operation enabled"
%       'szAxes' can only include one axis
%
%   SYNTAX
%       PIdevice.EAX(szAxes, iValues)
% 
%   INPUT
%       szAxes (char array)         string with axes
%
%       iValues (int array)         enable status for the specified axes, 
%                                   1 for "on", 0 for "off"
%  
%   PI MATLAB Class Library Version 1.5.0    
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CallGcs_InAxes_InInt32Array_Function(c,mfilename,szAxes,iValues)

