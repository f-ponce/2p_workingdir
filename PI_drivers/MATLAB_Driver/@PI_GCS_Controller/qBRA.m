function [iValues] = qBRA(c,szAxes)
%   DESCRIPTION
%   Gets brake activation state of given axes.
%
%   SYNTAX
%       [iValues] = PIdevice.qBRA(szAxes) 
% 
%   INPUT
%       szAxes (char array)            string with axes
%
%   OUTPUT
%       [iValues] (int array)          1 for true, 0 for false
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    iValues = CallGcs_InAxes_OutInt32Array_Function(c, mfilename);
else
    iValues = CallGcs_InAxes_OutInt32Array_Function(c, mfilename, szAxes);
end    
