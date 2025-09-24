function CTI( c, iTriggerInputIds, iTriggerParameterArray, szValueArray )
%   DESCRIPTION
%   Configures the trigger input conditions for the give digital input line. Depending on the 
%   controller, the trigger input conditions will either become active immediately, or will
%   become active when activated with TRI().
%
%   SYNTAX
%       PIdevice.CTI(iTriggerInputIds, iTriggerParameterArray, szValueArray)
%
%   INPUT
%       iTriggerInputIds (int array)        is an array with the trigger input lines of the controller
% 
%       iTriggerParameterArray (int array)  is an array with the CTI parameter IDs
%
%       szValueArray (char array)           is a list of the values to which the CTI parameters are set.
%                                           The single values must be separated by a linefeed character
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    piTriggerInputIds = libpointer('int32Ptr', iTriggerInputIds);
    piTriggerParameterArray = libpointer('int32Ptr', iTriggerParameterArray);
    iArraySize = length(iTriggerParameterArray);
	try
        [ bRet ] = calllib ( c.libalias, functionName, c.ID, piTriggerInputIds, piTriggerParameterArray, szValueArray, iArraySize );
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
