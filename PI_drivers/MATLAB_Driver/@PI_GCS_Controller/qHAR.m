function [iValues] = qHAR(c,szAxes)
%   DESCRIPTION
%   Gets whether the hard stops of the axis can be used for reference moves.
%
%   SYNTAX
%       [iValues] = PIdevice.qHAR(szAxes)
% 
%   INPUT
%       szAxes (char array)         string with axes
%
%   OUTPUT
%       [iValues] (int array)       indicates whether the axis can be referenced
%                                   using the hard stop (= 1) or not (= 0).
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    iValues = CallGcs_InAxes_OutInt32Array_Function(c, mfilename);
else
    iValues = CallGcs_InAxes_OutInt32Array_Function(c, mfilename, szAxes);
end    

