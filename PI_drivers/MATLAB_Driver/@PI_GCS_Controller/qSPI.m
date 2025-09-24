function dValues = qSPI(c,szAxes)
%   DESCRIPTION
%   Gets the pivot point coordinates in the volatile memory.
%
%   SYNTAX
%       dValues = PIdevice.qSPI(szAxes)
% 
%   INPUT
%       szAxes (char array)         can be R, S and T. X, Y and Z can also be used as alias identifiers for R, S and T  
%
%   OUTPUT
%       dValues (double array)      value array of the pivot point coordinates in physical units
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    dValues = CallGcs_InAxes_OutDoubleArray_Function(c, mfilename);
else
    dValues = CallGcs_InAxes_OutDoubleArray_Function(c, mfilename, szAxes);
end    
