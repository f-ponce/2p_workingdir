function [sAnswer] = qMAN(c,szCommand)
%   DESCRIPTION
%   Shows a detailed help text for individual commands.
%
%   SYNTAX
%       [sAnswer] = PIdevice.qMAN(szCommand)
% 
%   INPUT
%       szCommand (char array)      is the command mnemonic of the command for which the help text is to be displayed.
%
%   OUTPUT
%       [sAnswer] (char array)      buffer to receive the string that describes the command.
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[sAnswer] = CallGcs_InNArgs_OutString_Function(c,mfilename,1024,szCommand);
