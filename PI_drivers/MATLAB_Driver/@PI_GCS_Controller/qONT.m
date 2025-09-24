function [iValues] = qONT(c,szAxes)
%   DESCRIPTION
%   Check if szAxes have reached the target. 
%
%   For controllers with GCS3.0 syntax:
%       szAxes can only include one axis or None for all axes
%
%
%   SYNTAX
%       [iValues] = PIdevice.qONT(szAxes)
% 
%   INPUT
%       szAxes (char array)         string with axes
%
%   OUTPUT
%       [iValues] (int array)       array to be filled with current on-target state of the axes 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    iValues = CallGcs_InAxesOrNone_OutInt32Array_Function(c, mfilename);
else
    iValues = CallGcs_InAxesOrNone_OutInt32Array_Function(c, mfilename, szAxes);
end    
