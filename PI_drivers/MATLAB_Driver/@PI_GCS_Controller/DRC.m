function DRC (c, recordTableId, recordSourceId, recordOptionId)
%   DESCRIPTION 
%   Set data recorder configuration: determines the data source (recordSourceId) and the kind of 
%   data (recordOptionId) used for the given data recorder table. 
%
%   SYNTAX 
%       PIdevice.DRC(recordTableId, recordSourceId, recordOptionId)
% 
%    
%   INPUT 
%       recordTableId (int array)     ID of the table the data will be stored in.
%                                     Needed for function "qDRR()".
%   
%       recordSourceId (char array)   Can be axis or channel name.
%                   
%     
%       recordOptionId (int array)    Describes what kind of data will be
%                                     recorded. A full list is provided in the
%                                     controller manual or by function "qHDR()".
%                                     Frequently used options are:
%                                     1 = Commanded position of axis
%                                     2 = Actual position of axis
% 
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	pRecordTableId  = libpointer('int32Ptr',recordTableId);
	pRecordOptionId = libpointer('int32Ptr',recordOptionId);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,pRecordTableId,recordSourceId,pRecordOptionId);
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