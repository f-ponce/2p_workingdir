function [sAnswer] = qRMC(c)
%   DESCRIPTION
%   List macros which are currently running.
%   See “Controller Macros” and the MAC command description in the controller User Manual for details.
%
%   SYNTAX
%       [sAnswer] = PIdevice.qRMC()
%
%   OUTPUT
%       [sAnswer] (char array)          buffer to receive the string read in from controller, lines are separated by line-feed 
%                                       characters. Contains the names of the macros which are saved on the controller and currently 
%                                       running. The response is an empty line when no macro is running. 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[sAnswer] = CallGcs_InNArgs_OutString_Function(c,mfilename, 8192);
