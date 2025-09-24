function DRT (c, recordTableId, triggerSource, triggerSourceValue)
%   DESCRIPTION 
%   Defines a trigger source for the given data recorder table. For the data recorder configuration,
%   i.e. for the assignment of data sources and record options to the recorder tables, use DRC().
%   With qDRR() you can read the last recorded data set.
%   For more information see “Data Recorder” in the controller User Manual.
%
%
%   SYNTAX 
%       PIdevice.DRT(recordTableId, triggerSource, triggerSourceValue)
%    
%   INPUT 
%       recordTableId (int array)          Usualy "0". For further options please read
%                                          the controller manual.
%   
%       triggerSource (int array)          Defines the condition which triggers the
%                                          data recorder. Read the controller manual
%                                          or use function "qHDR()" to get all
%                                          available options for triggerSource.
%                                          Frequently used options are (may not work
%                                          for all controllers): 
%                                          0 = default setting 
%                                          1 = any command changing position (e.g. MOV) 
%                                          2 = next command 
%     
%       triggerSourceValue (char array)    Additional parameter for special
%                                          configuration. Set to "'0'" if not needed,
%                                          otherwise read the manual.
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piRecordTableId = libpointer('int32Ptr',recordTableId);
	piTriggerSource = libpointer('int32Ptr',triggerSource);
	nValues = length(triggerSource);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,piRecordTableId,piTriggerSource,triggerSourceValue,nValues);
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
