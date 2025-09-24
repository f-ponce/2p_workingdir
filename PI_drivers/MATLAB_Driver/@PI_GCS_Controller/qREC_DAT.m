function [numberOfTraceIndices,dataValues,gcsArrayHeaderBuffer] = qREC_DAT(c,recorderId,dataFormat,offset,numberOfValues,traceIndices)  
%   DESCRIPTION
%   
%   Reads the recorded data points from the traces of a data recorder.
%    
%
%   SYNTAX
%        [numberOfTraceIndices,dataValues,gcsArrayHeaderBuffer] = PIdevice.qREC_DAT(recorderId,dataFormat,offset,numberOfValues,traceIndices)
% 
%   INPUT
%       recorderId (char array)                            The data recorder to be queried
%
%       dataFormat (char array)                            Data format in which the data is to be transmitted
% 
%       offset (int)                                       Index of the data point from which the data should be read out
%
%       numberOfValues (int)                               Number of data points to be read out per trace
%
%       traceIndices (int array)                           The data recorder traces to be read
%
%   OUTPUT
%       [numberOfTraceIndices] (int)                       The number of traces in 'traceIndices'
% 
%       [dataValues] (int array)                           Memory in which the read values are written asynchronously. 
%
%       [gcsArrayHeaderBuffer] (char array)                Memory for the GCS array header
%      
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end
recorderId = ConvertCellArrayStringToString (recorderId);
dataFormat = ConvertCellArrayStringToString (dataFormat);
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    traceIndices = libpointer('int32Ptr',traceIndices);
    gcsArrayHeaderBuffer =  blanks(10001);
    numberOfTraceIndices = zeros(1,1);
	dataValues = libpointer('doublePtr');
	try
	    [bRet,~,~,numberOfTraceIndices,dataValues,gcsArrayHeaderBuffer] = calllib(c.libalias,functionName,c.ID,recorderId,dataFormat,offset,numberOfValues,traceIndices,numberOfTraceIndices,dataValues,gcsArrayHeaderBuffer,10000);	
        if(bRet==0)
			iError = GetError(c);
			szDesc = TranslateError(c,iError);
			error(szDesc);
		end
	catch
		rethrow(lasterror);
    end
    
    [dataValues] = ReadGCS30Array(c,gcsArrayHeaderBuffer, dataValues);
else
	error('%s not found',functionName);
end
