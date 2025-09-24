function OVL(c,iPIEZOWALKChannelsArray,dInValues)
%   DESCRIPTION
%   Set velocity for open-loop nanostepping motion of given PiezoWalk channel.
%   The OVL() setting only takes effect when the given axis is in open-loop operation (servo off).
%
%   SYNTAX
%       PIdevice.OVL(iPIEZOWALKChannelsArray,dInValues)
% 
%   INPUT
%       iPIEZOWALKChannelsArray (int array)         array with PIEZOWALK channels
%
%       dInValues (double array)                    maximum velocities for the axes 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piPIEZOWALKChannelsArray = libpointer('int32Ptr',iPIEZOWALKChannelsArray);
	pdInValues = libpointer('doublePtr',dInValues);
	nValues = length(dInValues);
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
