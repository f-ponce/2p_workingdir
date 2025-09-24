function [usg] = qUSG_HW(c,chapter)
%   DESCRIPTION
%   
%   Outputs the "HW" section of the User Guide.
%   The "HW" section contains information on the current hardware configuration and the associated firmware.
%    
%
%   SYNTAX
%        [usg] = PIdevice.qUSG_HW(chapter)
% 
%   INPUT
%       chapter (char array)                     Command for which information is to be requested.
%
%   OUTPUT
%       [usg] (char array)                       Memory for the answer
%      
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT � PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(nargin==1)
    [usg] = CallGcs_InCharArray_OutCharArray_Function(c,mfilename);
else
    [usg] = CallGcs_InCharArray_OutCharArray_Function(c,mfilename,chapter);
end