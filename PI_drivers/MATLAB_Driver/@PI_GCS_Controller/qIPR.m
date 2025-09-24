function [szBuffer] = qIPR(c)
%   DESCRIPTION
%   
%   Queries the assignment of the currently used communication interface to a GCS interpreter.
%    
%
%   SYNTAX
%        [szBuffer] = PIdevice.qIPR()
%
%   OUTPUT
%       [szBuffer] (char array)                       Memory for the answer
%      
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[szBuffer] = CallGcs_OutCharArray_Function(c,mfilename);

end