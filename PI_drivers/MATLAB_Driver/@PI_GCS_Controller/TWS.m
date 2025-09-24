function TWS(c,iInTriggerChannelIdsArray,iPointNumberArray,iSwitchArray)
%   DESCRIPTION
%   Sets trigger line actions to waveform points for the given trigger output line.
%   The power-on default state of all points is low. Afterwards, the signal state of the trigger output line can be 
%   switched to "low" for all points using TWC(). It is recommended to use TWC() before trigger actions 
%   are set with TWS().
%   For the selected trigger output line the generator trigger mode must be activated by CTO().
%   
%   SYNTAX
%       PIdevice.TWS(iInTriggerChannelIdsArray,iPointNumberArray,iSwitchArray)
% 
%   INPUT
%       iInTriggerChannelIdsArray (int array)   array with the trigger output lines. 
%
%       iPointNumberArray (int array)           array with the wave points. 
%
%       iSwitchArray (int array)                with the signal states of the trigger output lines at the wave points, 
%                                               if zero the trigger is set low, otherwise the trigger is set high.
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piInTriggerChannelIdsArray = libpointer('int32Ptr',iInTriggerChannelIdsArray);
	piPointNumberArray = libpointer('int32Ptr',iPointNumberArray);
	piSwitchArray = libpointer('int32Ptr',iSwitchArray);
	nValues = length(iInTriggerChannelIdsArray);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,piInTriggerChannelIdsArray,piPointNumberArray,piSwitchArray,nValues);
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
