function dValues = qMOV(c,szAxes)
%   DESCRIPTION
%   Read the commanded target positions for szAxes. Use qPOS() to get the current positions. 
%
%   For controllers with GCS 3.0 syntax:
%       szAxes can only include one axis or None for all axes
%
%   SYNTAX
%       dValues = PIdevice.qMOV(szAxes)
% 
%   INPUT
%       szAxes (char array)         string with axes
%
%   OUTPUT
%       dValues (double array)      array to be filled with target positions of the axes 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    dValues = CallGcs_InAxesOrNone_OutDoubleArray_Function(c, mfilename);
else
    szAxes = ConvertCellArrayStringToString (szAxes);
    dValues = CallGcs_InAxesOrNone_OutDoubleArray_Function(c, mfilename, szAxes);
end    
