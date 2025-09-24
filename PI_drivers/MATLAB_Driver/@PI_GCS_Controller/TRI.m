function TRI ( c, iTriggerInputIds, bTriggerState )
%   DESCRIPTION
%   Enables or disables the trigger input mode which was set with CTI() for the given digital input line.
%
%   SYNTAX
%       PIdevice.TRI(iTriggerInputIds, bTriggerState)
% 
%   INPUT
%       iTriggerInputIds (int array)      is an array with the digital input lines of the controller. 
%
%       bTriggerState (int array)         pointer to boolean array with modes for the specified trigger lines,
%                                            1 for "on", 
%                                            0 for "off"
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    piTriggerInputIds = libpointer('int32Ptr', iTriggerInputIds);
    pbTriggerState = libpointer('int32Ptr', bTriggerState);
    iArraySize = length(bTriggerState);
	try
        [ bRet ] = calllib ( c.libalias, functionName, c.ID, piTriggerInputIds, pbTriggerState, iArraySize );
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
