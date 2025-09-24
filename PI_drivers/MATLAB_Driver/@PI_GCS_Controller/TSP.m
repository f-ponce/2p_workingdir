function TSP(c,piSensorsChannelsArray,pdValueArray)
%   DESCRIPTION
%   
%   Set current sensor position. Only possible when the reference mode is switched off, see RON().  
%    
%
%   SYNTAX
%        PIdevice.TSP(piSensorsChannelsArray,pdValueArray)
% 
%   INPUT
%       piSensorsChannelsArray (int array)            Sensor channel number
%
%       pdValueArray (double array) 
%
%   
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    piSensorsChannelsArray = libpointer('int32Ptr',piSensorsChannelsArray);
    pdValueArray = libpointer('doublePtr',pdValueArray);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,piSensorsChannelsArray,pdValueArray,length(piSensorsChannelsArray));
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