function OSM(c,iPIEZOWALKChannelsArray,iValues)
%   DESCRIPTION
%   Open-loop step moving of the given PiezoWalk channel.
%   Prior to using OSM(), servo must be disabled for the axis to which the PiezoWalk channel is assigned
%   (open-loop operation).
%
%   SYNTAX
%       PIdevice.OSM(iPIEZOWALKChannelsArray,iValues)
% 
%   INPUT
%       iPIEZOWALKChannelsArray (int array)         array with PiezoWalk channels
%
%       iValues (int array)                         number of steps for the PiezoWalk channels (integer steps only)
%    
%   PI MATLAB Class Library Version 1.5.0  
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piPIEZOWALKChannelsArray = libpointer('int32Ptr',iPIEZOWALKChannelsArray);
	piValues = libpointer('int32Ptr',iValues);
	nValues = length(iPIEZOWALKChannelsArray);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,piPIEZOWALKChannelsArray,piValues,nValues);
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
