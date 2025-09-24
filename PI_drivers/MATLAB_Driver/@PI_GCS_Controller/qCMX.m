function dValues = qCMX(c,szAxes)
%   DESCRIPTION
%   Get the maximum commandable closed-loop target of szAxes. The physical unit and hence the
%   interpretation of the value depend on the closed-loop control mode which is selected  for  the  axis  (see 
%   CMO() for selection). 
%
%   SYNTAX
%       dValues = PIdevice.qCMX(szAxes)
% 
%   INPUT
%       szAxes (char array)         string with axes
%
%   OUTPUT
%       dValues (double array)      array to receive the maximum commandable closed-loop target of the axes in physical units.
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    dValues = CallGcs_InAxes_OutDoubleArray_Function(c, mfilename);
else
    dValues = CallGcs_InAxes_OutDoubleArray_Function(c, mfilename, szAxes);
end    
