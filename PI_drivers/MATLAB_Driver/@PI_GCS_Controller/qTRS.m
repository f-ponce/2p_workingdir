function [iValues] = qTRS(c,szAxes)
%   DESCRIPTION
%   Ask if szAxes have reference sensors with direction sensing.
%
%   SYNTAX
%       [iValues] = PIdevice.qTRS(szAxes)
% 
%   INPUT
%       szAxes (char array)       string with axes, if '' or no parameters were passed, all axes are affected
%
%   OUTPUT
%       [iValues]                 array for reference sensor info:
%                                 1 if axis has a reference sensor with direction sensing,
%                                 0 if not 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    iValues = CallGcs_InAxes_OutInt32Array_Function(c, mfilename);
else
    iValues = CallGcs_InAxes_OutInt32Array_Function(c, mfilename, szAxes);
end    
