function [pdValueArray] = qDDL_SYNC(c,iDdlTableId,iOffsetOfFirstPointInDdlTable,iNumberOfValues)  
%   DESCRIPTION
%   
%   Get the dynamic digital linearization feature data from a DDL data table from the controller.
%   For large NumberOfValues, communication timeout must be set long enough, otherwise a communication error may occur.
%    
%
%   SYNTAX
%        [pdValueArray] = PIdevice.qDDL_SYNC(iDdlTableId,iOffsetOfFirstPointInDdlTable,iNumberOfValues)
% 
%   INPUT
%       iDdlTableId (int)                                   ID of the DDL data table
%
%       iOffsetOfFirstPointInDdlTable (int)                 index in the DDL table of first value to be read, the first value in the DDL table has index 1            
% 
%       iNumberOfValues (int)                               number of values to be read
%
%   OUTPUT
%       [pdValueArray] (double array)                       Array to receive the values. Caller is responsible for providing enough space for iNumberOfValues doubles
%      
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    pdValueArray = zeros(iNumberOfValues,1); 
	pdValueArray = libpointer('doublePtr',pdValueArray);
	try
		[bRet,pdValueArray] = calllib(c.libalias,functionName,c.ID,iDdlTableId,iOffsetOfFirstPointInDdlTable,iNumberOfValues,pdValueArray);
		if(bRet==0)
			iError = GetError(c);
			szDesc = TranslateError(c,iError);
			error(szDesc);
		end
	catch
		rethrow(lasterror);
	end
else
	error('%s not found',functionName);
end