function [usg] = qUSG(c)
%   DESCRIPTION
%   
%   Outputs a "User Guide" with help texts for the controls.
%    
%
%   SYNTAX
%        [usg] = PIdevice.qUSG()
%
%   OUTPUT
%       [usg] (char array)                       Memory for the answer
%      
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[usg] = CallGcs_OutCharArray_Function(c,mfilename);

end
