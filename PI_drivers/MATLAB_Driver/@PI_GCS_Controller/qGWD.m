function [dOutValues, sHeader] = qGWD(c,tabelIds, startPoint, numberOfPoints)
%   DESCRIPTION
%   Read wave tables. This function reads the data asynchronously, it will return as soon as the data header 
%   has been read and start a background process which reads in the data itself. See GetAsyncBuffer() 
%   and GetAsyncBufferIndex(). Detailed information about the data read in can be found in the header 
%   sent by the controller. See the GCS Array manual for details.
%   Depending on the waveform definition with WAV(), the wave tables may have different lengths. But due 
%   to the definition of the GCS array as the response format, it is not possible to read tables with different 
%   lengths at the same time. You can ask with qWAV() for the current length of the wave tables.
%    
%   SYNTAX
%       [dOutValues, sHeader] = PIdevice.qGWD(tabelIds, startPoint, numberOfPoints)
% 
%   INPUT
%       tabelIds (int array)                IDs of wave tables 
%   
%       startPoint (int)                    index of first value to be read (starts with index 1)
%
%       numberOfPoints (int)                number of values to read
%
%   OUTPUT
%       [dOutValues] (double array)         data from all tables read will be placed in the 
%                                           same array with the values interspersed; the DLL will allocate enough memory to store all data, 
%                                           call GetAsyncBufferIndex() to find out how many data points have already been transferred
%
%       [sHeader] (char array)              buffer to store the GCS array header
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[dOutValues, sHeader] = CallGcs_InInt32ArrayInt32ArgInt32Arg_OufDoubleArryPrtString(c,mfilename, tabelIds, startPoint, numberOfPoints);
