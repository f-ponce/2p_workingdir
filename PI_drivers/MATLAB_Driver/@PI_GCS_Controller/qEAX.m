function [iValues] = qEAX(c,szAxes)
%   DESCRIPTION
%   Get enable status of axes: enabled/not enabled.
%
%   For controllers with GCS 3.0 syntax:
%       szAxes can only include one axis or None for all axes
%
%
%   SYNTAX
%       [iValues] = PIdevice.qEAX(szAxes)
% 
%   INPUT
%       szAxes (char array)         string with axes
%
%   OUTPUT
%       [iValues] (int array)       enable status for the specified axes,
%                                   1 for "enabled"
%                                   0 for "not enabled"
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    iValues = CallGcs_InAxesOrNone_OutInt32Array_Function(c, mfilename);
else
    iValues = CallGcs_InAxesOrNone_OutInt32Array_Function(c, mfilename, szAxes);
end    
