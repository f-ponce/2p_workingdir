function [iValues] = qSSL(c,szAxes)
%   DESCRIPTION
%   Gets the state of the soft limits that are set with NLM() and PLM(). 
%   If all arguments are omitted, the state is queried for all axes.
%
%   SYNTAX
%       [iValues] = PIdevice.qSSL(szAxes)
% 
%   INPUT
%       szAxes (char array)             axes of the controller
%
%   OUTPUT
%       [iValues] (int array)           array to receive the state of the soft limits:
%                                         0 = soft limits deactivated
%                                         1 = soft limits activated
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    iValues = CallGcs_InAxes_OutInt32Array_Function(c, mfilename);
else
    iValues = CallGcs_InAxes_OutInt32Array_Function(c, mfilename, szAxes);
end    
