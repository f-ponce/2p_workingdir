function iValues = qLIM(c,szAxes)
%   DESCRIPTION
%   Check if the given axes have limit switches.
%
%   SYNTAX
%       iValues = PIdevice.qLIM(szAxes) 
% 
%   INPUT
%       szAxes (char array)         string with axes
%
%   OUTPUT
%       iValues (int array)         array for limit switch info:
%                                   1 if axis has limit switches, 
%                                   0 if not 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    iValues = CallGcs_InAxes_OutInt32Array_Function(c, mfilename);
else
    iValues = CallGcs_InAxes_OutInt32Array_Function(c, mfilename, szAxes);
end    

