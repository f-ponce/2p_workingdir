function TRO(c,iTriggerOutputIds,bTriggerState)
%   DESCRIPTION
%   Enables or disables the trigger output mode which was set with CTO() for the given digital output line.
%
%   SYNTAX
%       PIdevice.TRO(iTriggerOutputIds,bTriggerState)
% 
%   INPUT
%       iTriggerOutputIds (int array)       is an array with the digital output lines of the controller.
%
%       bTriggerState (int array)           pointer to boolean array with modes for the specified trigger lines, 
%                                           1 for "on", 
%                                           0 for "off" 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piTriggerOutputIds = libpointer('int32Ptr',iTriggerOutputIds);
	pbTriggerState = libpointer('int32Ptr',bTriggerState);
	nValues = length(iTriggerOutputIds);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,piTriggerOutputIds,pbTriggerState,nValues);
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
