function [iRet] = GetAsyncBufferIndex(c)
%   DESCRIPTION
%   Get index used for the internal buffer filled with data read in by a call to qDRR(), qDDL(), 
%   qGWD(), qTWS(), qJLT() or qHIT().
%
%   SYNTAX
%       PIdevice.GetAsyncBufferIndex
% 
%   OUTPUT
%       [iRet] (int)        Index of the data element which was last read in, -1 otherwise 
%  
%   PI MATLAB Class Library Version 1.5.0    
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[iRet] = calllib(c.libalias,functionName,c.ID);
	catch
		rethrow(lasterror);
	end
else
	error('%s not found',functionName);
end
