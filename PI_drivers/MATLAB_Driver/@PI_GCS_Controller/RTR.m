function RTR(c,iValues1)
%   DESCRIPTION
%   Sets the record table rate, i.e. the number of servo-loop cycles to be 
%   used in data recording operations. Settings larger than 1 make it
%   possible to cover longer time periods with a limited number of points.
%   For more information see "Data Recorder" in the controller User Manual
%
%   SYNTAX
%       PIdevice.RTR(iValues1)
%
%   INPUT
%       iValues (int array)                 Is the record table rate to be used (unit: number of servo-loop cycles), 
%                                           must be larger than zero
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,iValues1);
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
