function OAD(c,iInPIEZOWALKChannelsArray,dInValues)
%   DESCRIPTION
%   Open-loop analog driving of the given PiezoWalk channel.
%   Servo must be disabled for the commanded axis prior to using this command (open-loop operation).
%
%   SYNTAX
%       PIdevice.OAD(iInPIEZOWALKChannelsArray, dInValues)
% 
%   INPUT
%       iInPIEZOWALKChannelsArray (int array)       array with PiezoWalk channels
%
%       dInValues (double array)                    is the feed voltage amplitude in V, see above for details
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piInPIEZOWALKChannelsArray = libpointer('int32Ptr',iInPIEZOWALKChannelsArray);
	pdInValues = libpointer('doublePtr',dInValues);
	nValues = length(iInPIEZOWALKChannelsArray);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,piInPIEZOWALKChannelsArray,pdInValues,nValues);
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
