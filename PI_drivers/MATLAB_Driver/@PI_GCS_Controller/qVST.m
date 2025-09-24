function [sAnswer] = qVST(c)
%   DESCRIPTION
%   Get the names of the available positioner types. The available positioners are read from positioner database(s).
%   The positioner types listed with qVST() can be assigned to the axes of the controller with CST().
%   C-887:
%   Note that the assignment of a positioner type with CST() is only permissible for axes A and B. The 
%   behavior of the qVST() and CST() functions differs depending on the current versions of the 
%   controller firmware and PI GCS 2 DLL.
%
%   SYNTAX
%       [sAnswer] = PIdevice.qVST()
%
%   OUTPUT
%       [sAnswer] (char array)          buffer for storing the string read in, lines are separated by \n (line feed) 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[sAnswer] = CallGcs_InNArgs_OutString_Function(c,mfilename, 8192);
