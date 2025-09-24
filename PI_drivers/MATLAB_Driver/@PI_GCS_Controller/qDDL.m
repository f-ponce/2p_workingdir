function [dOutValues, sHeader] = qDDL(c,tabelIds, startPoint, numberOfPoints)
%   DESCRIPTION
%   Transfer dynamic digital linearization feature data to a DDL data table on the controller. 
%
%   SYNTAX
%       [dOutValues, sHeader] = PIdevice.qDDL(tabelIds, startPoint, numberOfPoints)
% 
%   INPUT
%       tabelIds (int)                  number of the DDL data table to use
%
%       startPoint (int)                index of first value to be transferred,
%                                       (the first value in the DDL table has index 1)
%
%       numberOfPoints (int)            number of values to be transferred 
%
%   OUTPUT
%       [dOutValues] (double array)     array with the values for the DDL table 
%
%       [sHeader] (char array)		buffer to store the GCS array header
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[dOutValues, sHeader] = CallGcs_InInt32ArrayInt32ArgInt32Arg_OufDoubleArryPrtString(c,mfilename, tabelIds, startPoint, numberOfPoints);