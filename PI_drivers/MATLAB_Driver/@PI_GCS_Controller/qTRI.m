function [bTriggerState] = qTRI ( c, iTriggerInputIds )
%   DESCRIPTION
%   Returns if the trigger input configuration made with CTI() is enabled or disabled
%   for the given digital input line.
%
%   SYNTAX
%       [bTriggerState] = PIdevice.qTRI(iTriggerInputIds)
% 
%   INPUT
%       iTriggerInputIds (int array)      digital input lines of the controller
%
%   OUTPUT
%       [bTriggerState] (int array)       the current states of the digital input lines:
%                                             0 = Trigger input disabled
%                                             1 = Trigger input enabled     
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    piTriggerInputIds = libpointer('int32Ptr', iTriggerInputIds);
    bTriggerState = zeros ( size ( iTriggerInputIds ) );
    pbTriggerState = libpointer('int32Ptr', bTriggerState);
    iNumberOfInputIds = length ( iTriggerInputIds );
	try
        [ bRet, ~, bTriggerState ] = calllib ( c.libalias, functionName, c.ID, piTriggerInputIds, pbTriggerState, iNumberOfInputIds );
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
