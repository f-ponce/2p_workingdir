function [numDataValues] = qREC_NUM(c,recorderIds)
%   DESCRIPTION
%   
%   Gets the current number of recorded data points.
%    
%
%   SYNTAX
%        [numDataValues] = PIdevice.qREC_NUM(recorderIds)
% 
%   INPUT
%       recorderIds (char array)               The data recorder(s) to be queried
%
%   OUTPUT
%       [numDataValues] (int array)            The current recorded length of the data recorder(s)
%      
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    [numDataValues] = CallGcs_InCharArray_OutInt32Array_Function(c,mfilename);
else
    [numDataValues] = CallGcs_InCharArray_OutInt32Array_Function(c,mfilename,recorderIds);
end
