function [userCommandLevel] = qUCL(c)
%   DESCRIPTION
%   
%   Returns the current command level.
%    
%
%   SYNTAX
%        [userCommandLevel] = PIdevice.qUCL()
% 
%   OUTPUT
%       [userCommandLevel] (char array)            The current command level
%      
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[userCommandLevel] = CallGcs_OutCharArray_Function(c,mfilename);

end