function [iOutValues] = qWGO(c,iInValues)
%   DESCRIPTION
%   Get the start/stop mode of the given wave generator.
%   Note: Ask with IsGeneratorRunning() for the current activation state of the wave generator. The reply 
%   shows if a wave generator is running or not, but does not contain any information about the wave 
%   generator start mode (e.g. with trigger output). With qWGO you can ask for the last commanded wave 
%   generator start option (set by WGO).
%
%   SYNTAX
%       [iOutValues] = PIdevice.qWGO(iInValues)
% 
%   INPUT
%       iInValues (int array)           array with wave generators for which the start mode values will be read out
%
%   OUTPUT
%       [iOutValues] (int array)         array with modes for each wave generator in iInValues
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT � PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piValues = libpointer('int32Ptr',iInValues);
	iOutValues = zeros(size(iInValues));
	piOutValues = libpointer('int32Ptr',iOutValues);
	nValues = length(iInValues);
	try
		[bRet,~,iOutValues] = calllib(c.libalias,functionName,c.ID,piValues,piOutValues,nValues);
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
