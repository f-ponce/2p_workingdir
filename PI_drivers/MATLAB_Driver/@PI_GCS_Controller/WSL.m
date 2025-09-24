function WSL(c,iWaveGeneratorIdsArray,iWaveTableIdsArray)
%   DESCRIPTION
%   Wave table selection: connects a wave table to a wave generator or disconnects the selected generator 
%   from any wave table.
%   Two or more generators can be connected to the same wave table, but a generator cannot be connected 
%   to more than one wave table.
%   Deleting wave table content with WCL has no effect on the WSL settings.
%   As long as a wave generator is running, it is not possible to change the connected wave table.
%
%   SYNTAX
%       PIdevice.WSL(iWaveGeneratorIdsArray,iWaveTableIdsArray)
% 
%   INPUT
%       iWaveGeneratorIdsArray (int array)          array with wave generators. 
%
%       iWaveTableIdsArray (int array)              array with the wave table ID. "0" disconnects the 
%                                                   selected generator from any wave table.
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piWaveGeneratorIdsArray = libpointer('int32Ptr',iWaveGeneratorIdsArray);
	piWaveTableIdsArray = libpointer('int32Ptr',iWaveTableIdsArray);
	nValues = length(iWaveGeneratorIdsArray);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,piWaveGeneratorIdsArray,piWaveTableIdsArray,nValues);
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
