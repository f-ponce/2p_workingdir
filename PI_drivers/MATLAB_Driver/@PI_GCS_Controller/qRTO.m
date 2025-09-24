function [iValues] = qRTO(c,szAxes)
%   DESCRIPTION
%   Read the "ready-for-turn-off state" of the given axis (check whether RTO() was successful). 
%
%   SYNTAX
%       [iValues] = PIdevice.qRTO(szAxes)
% 
%   INPUT
%       szAxes (char array)         string with axes, if ##, all axes are affected
%
%   OUTPUT
%       [iValues] (int array)       array to receive, 1 if ready (i.e. RTO() was successful),
%                                   0 if not ready (i.e. RTO() was not successful)
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    iValues = CallGcs_InAxes_OutInt32Array_Function(c, mfilename);
else
    iValues = CallGcs_InAxes_OutInt32Array_Function(c, mfilename, szAxes);
end    
