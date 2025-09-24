function [dOutValues, sHeader] = qHIT (c, tabelIds, startPoint, numberOfPoints)
%   DESCRIPTION
%   Gets the values of the given points in the given lookup table.
%
%   SYNTAX
%       [dOutValues, sHeader] = PIdevice.qHIT(tabelIds, startPoint, numberOfPoints)
% 
%   INPUT
%       tabelIds (int array)            IDs of the lookup tables of the controller
%
%       startPoint (int)                index of first point to be read (starts with index 1)
%
%       numberOfPoints (int)            number of points to read
%   
%   OUTPUT
%       [dOutValues] (double array)     data from all tables read will be placed in the same array with the values interspersed; 
%                                       the DLL will allocate enough memory to store all data, call PI_GetAsyncBufferIndex()
%                                       to find out how many data points have already been transferred  
%
%       [sHeader] (char array)          buffer to store the GCS array header
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[dOutValues, sHeader] = CallGcs_InInt32ArrayInt32ArgInt32Arg_OufDoubleArryPrtString(c,mfilename, tabelIds, startPoint, numberOfPoints);
