function OCD(c,iInPIEZOWALKChannelsArray,dInValues)
%   DESCRIPTION
%   Set open-loop deceleration of szAxes. The PI_ODC setting only takes effect when the given axis is in 
%   open-loop operation (servo off). 
%
%   SYNTAX
%       PIdevice.ODC(iInPIEZOWALKChannelsArray,dInValues)
% 
%   INPUT
%       iInPIEZOWALKChannelsArray (int array)       array with PiezoWalk channels
%
%       dInValues (double array)                    deceleration value
%  
%   PI MATLAB Class Library Version 1.5.0    
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piInPIEZOWALKChannelsArray = libpointer('int32Ptr',iInPIEZOWALKChannelsArray);
	pdInValues = libpointer('doublePtr',dInValues);
	nValues = length(iInPIEZOWALKChannelsArray);
	try
		[bRet,iInValues1,dInValues1] = calllib(c.libalias,functionName,c.ID,piInPIEZOWALKChannelsArray,pdInValues,nValues);
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
