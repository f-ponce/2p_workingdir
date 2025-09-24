function iValues = qDCO(c,szAxes)
%   DESCRIPTION
%   Gets drift compensation mode of szAxes
%
%   SYNTAX
%       iValues = PIdevice.qDCO(szAxes)
% 
%   INPUT
%       szAxes (char array)             string with axes
%
%   OUTPUT
%       iValues (int array)             array to receive the drift compensation modes of the specified axes,
%                                       1 for "on", 
%                                       0 for "off"
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT � PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    iValues = CallGcs_InAxes_OutInt32Array_Function(c, mfilename);
else
    iValues = CallGcs_InAxes_OutInt32Array_Function(c, mfilename, szAxes);
end    
