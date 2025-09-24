function [dOutValues, sHeader] = qTWS (c, tabelIds, startPoint, numberOfPoints)
%   DESCRIPTION
%   Reading of the trigger line settings made with TWS for the waveform points. This function reads the 
%   data asynchronously, it will return as soon as the data header has been read and start a background 
%   process which reads in the data itself. See GetAsyncBuffer() and GetAsyncBufferIndex(). Detailed 
%   information about the data read in can be found in the header sent by the controller. See the GCS Array 
%   manual for details. To query the waveform shape, use qGWD.
%
%   SYNTAX
%       [dOutValues, sHeader] = PIdevice.qTWS(tabelIds, startPoint, numberOfPoints)
% 
%   INPUT
%       tabelIds (int array)                IDs of the trigger line (digital output line)
%
%       startPoint (int)                    index of first value to be read (starts with index 1)
%
%       numberOfPoints (int)                number of values to read
%
%   OUTPUT
%       [dOutValues] (double array)         array to store the data; data from all trigger lines read will be placed in 
%                                           the same array with the values interspersed; the DLL will allocate enough memory to store all 
%                                           data, call GetAsyncBufferIndex() to find out how many data points have already been 
%
%       [sHeader] (char array)              buffer to store the GCS array header
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[dOutValues, sHeader] = CallGcs_InInt32ArrayInt32ArgInt32Arg_OufDoubleArryPrtString(c,mfilename, tabelIds, startPoint, numberOfPoints);
