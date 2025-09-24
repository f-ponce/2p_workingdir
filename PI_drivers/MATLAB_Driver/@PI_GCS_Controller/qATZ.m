function [iValues] = qATZ(c,szAxes)
%   DESCRIPTION
%   Reports if the AutoZero procedure called by PIdevice.ATZ(...) was
%   successful
%
%   SYNTAX
%       [iValues] = PIDevice.qATZ(szAxes)
%
%   INPUT
%       szAxes (char array)                 string with axes
%
%   OUTPUT
%       [iValues] (int array)               0 if AutoZero (ATZ()) procedure was not successful,
%                                             or ist still under progress.
%                                           1 if AutoZero (ATZ()) procedure was successfully performed
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    iValues = CallGcs_InAxes_OutInt32Array_Function(c, mfilename);
else
    iValues = CallGcs_InAxes_OutInt32Array_Function(c, mfilename, szAxes);
end    
