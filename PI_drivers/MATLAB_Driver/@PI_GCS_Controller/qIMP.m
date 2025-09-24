function dValues = qIMP(c,szAxes)
%   DESCRIPTION
%   Get last sent impulse parameters for given axis (sent with IMP()).
%
%   SYNTAX
%       dValues = PIdevice.qIMP(szAxes)
% 
%   INPUT
%       szAxes (char array)         axis for which the impulse parameters are to be read 
%
%   OUTPUT
%       dValues (double array)      Array to be filled with impulse parameters of the axes; 
%                                   currently only the pulse height.
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    dValues = CallGcs_InAxes_OutDoubleArray_Function(c, mfilename);
else
    dValues = CallGcs_InAxes_OutDoubleArray_Function(c, mfilename, szAxes);
end    
