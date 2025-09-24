function IMP(c,szAxes,dValues)
%   DESCRIPTION
%   Starts performing an impulse and recording the impulse response for the given axis. An "impulse" consists 
%   of a relative move of the specified amplitude followed by an equal relative move in the opposite direction.
%
%   SYNTAX
%       PIdevice.IMP(szAxes,dValues)
% 
%   INPUT
%       szAxes (char array)         axes for which the impulse response will be recorded 
%
%       dValues (double array)      array with the pulse height (amplitude values).
%    
%   PI MATLAB Class Library Version 1.5.0  
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CallGcs_InAxes_InDoubleArray_Function(c,mfilename,szAxes,dValues)
