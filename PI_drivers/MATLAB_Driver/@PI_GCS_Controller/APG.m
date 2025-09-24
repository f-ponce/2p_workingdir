function APG(c,piPIEZOWALKChannelsArray)
%   DESCRIPTION
%   
%   Auto Piezo Gain calibration. The specified Nexline channel is moved over the whole range by step moving while the resulting     
%   step sizes are measured. From these step sizes, the voltage-to-displacement-gain coefficients of a second order polynom are 
%   calculated for both moving directions.
%       
%
%   SYNTAX
%        PIdevice.APG(piPIEZOWALKChannelsArray)
% 
%   INPUT
%       piPIEZOWALKChannelsArray (int array)          the Nexline channel to move   
%
%   
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    piPIEZOWALKChannelsArray = libpointer('int32Ptr',piPIEZOWALKChannelsArray);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,piPIEZOWALKChannelsArray,length(piPIEZOWALKChannelsArray));
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