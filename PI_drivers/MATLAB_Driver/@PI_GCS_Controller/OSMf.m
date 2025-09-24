function OSMf(c,iPIEZOWALKChannelsArray,dInValues)
%   DESCRIPTION
%   Open-loop step moving of the given PiezoWalk channel.
%   Prior to using OSMf(), servo must be disabled for the axis to which the PiezoWalk channel is assigned
%   (open-loop operation).
%   OSMf() is identical with OSM() but allows to command parts of a step cycle (floating-point numbers
%   are accepted).
%
%   SYNTAX
%       PIdevice.OSMf(iPIEZOWALKChannelsArray,dInValues)
% 
%   INPUT
%       iPIEZOWALKChannelsArray (int array)         array with PiezoWalk channels 
%
%       dInValues (double array)                    number of steps for the PiezoWalk channels
%                                                   (floating-point numbers)
%   
%   PI MATLAB Class Library Version 1.5.0   
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piPIEZOWALKChannelsArray = libpointer('int32Ptr',iPIEZOWALKChannelsArray);
	pdInValues = libpointer('doublePtr',dInValues);
	nValues = length(iPIEZOWALKChannelsArray);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,piPIEZOWALKChannelsArray,pdInValues,nValues);
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
