function [iValues] = qSMO(c,szAxes)
%   DESCRIPTION
%   Gets last valid control value of szAxes.
%
%   SYNTAX
%       [iValues] = PIdevice.qSMO(szAxes)
% 
%   INPUT
%       szAxes (char array)         string with axes
%
%   OUTPUT
%       [iValues] (int array)       control values for the specified axes. 
%                                   In servo-on mode the current value, set by the controller,
%                                   is reported. In servo-off mode the value set by SMO() is reported.
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    iValues = CallGcs_InAxes_OutInt32Array_Function(c, mfilename);
else
    iValues = CallGcs_InAxes_OutInt32Array_Function(c, mfilename, szAxes);
end    
