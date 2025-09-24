function [iValues] = qSVO(c,szAxes)
%   DESCRIPTION
%   Get the servo-control mode for szAxes
%
%   For controllers with GCS 3.0 syntax:
%       szAxes can only include one axis or None for all axes
%
%   SYNTAX
%       [iValues] = PIdevice.qSVO(szAxes)
% 
%   INPUT
%       szAxes (char array)         string with axes
%
%   OUTPUT
%       [iValues] (int array)       array to receive the servo modes of the specified axes, 
%                                   1 for "on", 0 for "off" 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    iValues = CallGcs_InAxesOrNone_OutInt32Array_Function(c, mfilename);
else
    iValues = CallGcs_InAxesOrNone_OutInt32Array_Function(c, mfilename, szAxes);
end    
