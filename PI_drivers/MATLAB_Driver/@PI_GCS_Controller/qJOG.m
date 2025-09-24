function [dValues] = qJOG ( c, szAxes )
%   DESCRIPTION
%   Gets the velocities for motion of szAxes caused by PI_JOG()
%
%   SYNTAX
%       [dValues] = PIdevice.qJOG(szAxes)
%
%   INPUT
%       szAxes (char array)         string with axes
%
%   OUTPUT
%       [dValues] (double array)    jog velocities of the axes, see JOG()
%                                   for details
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    dValues = CallGcs_InAxes_OutDoubleArray_Function(c, mfilename);
else
    dValues = CallGcs_InAxes_OutDoubleArray_Function(c, mfilename, szAxes);
end    
