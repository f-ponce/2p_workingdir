function CTOString(c,TriggerOutputIds,TriggerParameterArray,szValue)
%   DESCRIPTION
%   Configures the trigger output conditions for the given digital output line. Depending on the controller,
%   the trigger output conditions will either become active immediately, or will become active when activated
%   with TRO().
%
%   SYNTAX
%       PIdevice.CTOString(TriggerOutputIds,TriggerParameterArray,szValue)
% 
%   INPUT
%       TriggerOutputIds (int array)        is an array with the trigger output lines of the controller
%
%       TriggerParameterArray (int array)   is an array with the CTO parameter IDs
%
%       szValue (char array)                is a list of the values to which the CTO parameters are set.
%                                           The single values must be separated by a linefeed character
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piTriggerOutputIds = libpointer('int32Ptr',TriggerOutputIds);
	piTriggerParameterArray = libpointer('int32Ptr',TriggerParameterArray);
	nValues = length(TriggerOutputIds);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,piTriggerOutputIds,piTriggerParameterArray,szValue,nValues);
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
