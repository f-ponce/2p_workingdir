function TWE(c,piWaveTableIdsArray,piWaveTableStartIndexArray,piWaveTableEndIndexArray)
%   DESCRIPTION
%   
%   Define the edges of a trigger signal which is to be output in conjunction with the wave generator output.
%       
%
%   SYNTAX
%        PIdevice.TWE(piWaveTableIdsArray,piWaveTableStartIndexArray,piWaveTableEndIndexArray)
% 
%   INPUT
%       piWaveTableIdsArray (int array)                     Table ID as integer convertible or list of them.
%
%       piWaveTableStartIndexArray (int array)              Wave table index where trigger starts as integer convertible or list of them.
%
%       piWaveTableEndIndexArray (int array)                Wave table index where trigger ends as integer convertible or list of them.
%
%   
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    piWaveTableIdsArray = libpointer('int32Ptr',piWaveTableIdsArray);
    piWaveTableStartIndexArray = libpointer('int32Ptr',piWaveTableStartIndexArray);
    piWaveTableEndIndexArray = libpointer('int32Ptr',piWaveTableEndIndexArray);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,piWaveTableIdsArray,piWaveTableStartIndexArray,piWaveTableEndIndexArray,length(piWaveTableIdsArray));
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