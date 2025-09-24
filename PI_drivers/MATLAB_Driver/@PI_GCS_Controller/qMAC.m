function [sAnswer] = qMAC(c,szAxes)
%   DESCRIPTION
%   Get available macros, or list contents of a specific macro. If szMacroName is empty or NULL, all available 
%   macros are listed in szBuffer, separated with line-feed characters. Otherwise the content of the macro with 
%   name szMacroName is listed, the single lines separated  by line-feed characters. If there are no macros 
%   stored or the requested macro is empty the answer will be "". 
%   See “Controller Macros” and the MAC command description in the controller User Manual for details. 
%   
%   SYNTAX
%       [sAnswer] = PIdevice.qMAC(szAxes)
% 
%   INPUT
%       szAxes (char array)         string with name of macro list
%
%   OUTPUT
%       [sAnswer] (char array)      buffer to receive the string read in from controller,
%                                   lines are separated by line-feed characters 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[sAnswer] = CallGcs_InNArgs_OutString_Function(c,mfilename,1024,szAxes);
