function [rateValues] = qREC_RATE(c,recorderIds)
%   DESCRIPTION
%   
%   Gets the sample rate of the data recorder.
%    
%
%   SYNTAX
%        [rateValues] = PIdevice.qREC_RATE(recorderIds)
% 
%   INPUT
%       recorderIds (char array)             The data recorder whose configuration is to be queried
%
%   OUTPUT
%       [rateValues] (int array)             The sample rate(s) of the data recorder(s)
%      
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    [rateValues] = CallGcs_InCharArray_OutInt32Array_Function(c,mfilename);
else
    [rateValues] = CallGcs_InCharArray_OutInt32Array_Function(c,mfilename,recorderIds);
end
