function [usg] = qUSG_CMD(c,chapter)
%   DESCRIPTION
%   
%   Outputs the "CMD" section of the User Guide.
%   The "CMD" section contains a list of all commands that can be executed in the current user command level.
%    
%
%   SYNTAX
%        [usg] = PIdevice.qUSG_CMD(chapter)
% 
%   INPUT
%       chapter (char array)                     Command for which information is to be requested.
%
%   OUTPUT
%       [usg] (char array)                       Memory for the answer
%      
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(nargin==1)
    [usg] = CallGcs_InCharArray_OutCharArray_Function(c,mfilename);
else
    [usg] = CallGcs_InCharArray_OutCharArray_Function(c,mfilename,chapter);
end