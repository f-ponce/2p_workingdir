function VMI(c,iInPiezoChannelsArray,dInValues)
%   DESCRIPTION
%   Set lower PZT voltage soft limit of given piezo channel.
%
%   SYNTAX
%       PIdevice.VMI(iInPiezoChannelsArray,dInValues)
% 
%   INPUT
%       iInPiezoChannelsArray (int array)           array with piezo channels 
%
%       dInValues (double array)                    lower limits for piezo voltage 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piInPiezoChannelsArray = libpointer('int32Ptr',iInPiezoChannelsArray);
	pdInValues = libpointer('doublePtr',dInValues);
	nValues = length(iInPiezoChannelsArray);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,piInPiezoChannelsArray,pdInValues,nValues);
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
