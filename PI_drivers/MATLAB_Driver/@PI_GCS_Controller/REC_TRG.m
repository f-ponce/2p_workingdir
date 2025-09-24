function REC_TRG(c,recorderId,triggerMode,triggerOption1,triggerOption2)
%   DESCRIPTION
%   
%   Sets the trigger to start the recording. 
%   If necessary, REC_TRG also configures the properties of the trigger. 
%
%
%   SYNTAX
%        PIdevice.REC_TRG(recorderId,triggerMode,triggerOption1,triggerOption2)
% 
%   INPUT
%       recorderId (char array)                   The data recorder whose trigger is to be set
%
%       triggerMode (char array)                  The trigger to start recording
%       
%       triggerOption1 (char array)               First argument to configure the trigger
%
%       triggerOption2 (char array)               Second argument to configure the trigger
%
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
recorderId = ConvertCellArrayStringToString (recorderId);
triggerMode = ConvertCellArrayStringToString (triggerMode);
triggerOption1 = ConvertCellArrayStringToString (triggerOption1);
triggerOption2 = ConvertCellArrayStringToString (triggerOption2);
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,recorderId,triggerMode,triggerOption1,triggerOption2);
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
