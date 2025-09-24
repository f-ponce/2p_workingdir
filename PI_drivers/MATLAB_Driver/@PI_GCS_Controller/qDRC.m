function [szSourceIds,iRecordOptions] = qDRC(c,iRecordTables)
%   DESCRIPTION
%   Returns the data recorder configuration for the queried record table. The configuration can be changed
%   with DRC(). The recorded data can be read with qDRR().
%   Trigger options for recording can be set with DRT() and read with qDRT().
%
%   SYNTAX
%       [szSourceIds,iRecordOptions] = PIdevice.qDRC(iRecordTables)
% 
%   INPUT
%       iRecordTables (int array)       array of the record table IDs.
%
%   OUTPUT
%       [szSourceIds] (char array)      array to receive the record source (for example axis number or channel number. 
%                                       The meaning of this value depends on the corresponding record option).
%
%       [iRecordOptions] (int array)    array to receive the record option, i.e. the kind of data to be recorded
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piRecordTables = libpointer('int32Ptr',iRecordTables);
	iRecordOptions = zeros(size(iRecordTables));
	piRecordOptions = libpointer('int32Ptr',iRecordOptions);
	nValues = length(iRecordTables);
	szSourceIds = blanks(1001);
	try
		[bRet,~,szSourceIds,iRecordOptions] = calllib(c.libalias,functionName,c.ID,piRecordTables,szSourceIds,piRecordOptions,1000,nValues);
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
