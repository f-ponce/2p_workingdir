function [sAnswer] = qHDR(c)
%   DESCRIPTION
%   Lists a help string which contains all information available for data recording (record options and trigger 
%   options, information about additional parameters and commands regarding data recording).
%   For more information see “Data Recorder” in the controller User Manual.
%
%   SYNTAX
%       [sAnswer] = PIdevice.qHDR()
%
%   OUTPUT
%       [sAnswer] (char array)              buffer to receive the string read in from controller, 
%                                           lines are separated by '\n' ("line-feed") 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[sAnswer] = CallGcs_InNArgs_OutString_Function(c,mfilename, 8192);
