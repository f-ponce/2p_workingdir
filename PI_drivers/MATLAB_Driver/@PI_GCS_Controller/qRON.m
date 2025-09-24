function [iValues] = qRON(c,szAxes)
%   DESCRIPTION
%   Gets reference mode for given axes. 
%
%   SYNTAX
%       [iValues] = PIdevice.qRON(szAxes)
% 
%   INPUT
%       szAxes (char array)         string with axes
%
%   OUTPUT
%       [iValues] (int array)       array to receive reference modes for the specified axes 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    iValues = CallGcs_InAxes_OutInt32Array_Function(c, mfilename);
else
    iValues = CallGcs_InAxes_OutInt32Array_Function(c, mfilename, szAxes);
end    
