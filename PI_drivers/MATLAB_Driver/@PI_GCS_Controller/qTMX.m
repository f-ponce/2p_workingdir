function [dValues] = qTMX(c,szAxes)
%   DESCRIPTION
%   Get the high end of the travel range of szAxes
%
%   SYNTAX
%       [dValues] = PIdevice.qTMX(szAxes)
%
%   INPUT
%       szAxes (char array)        string with axes
%
%   OUTPUT
%       [iValues](int array)       array to receive high end of travel range of axes
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    dValues = CallGcs_InAxes_OutDoubleArray_Function(c, mfilename);
else
    dValues = CallGcs_InAxes_OutDoubleArray_Function(c, mfilename, szAxes);
end    
