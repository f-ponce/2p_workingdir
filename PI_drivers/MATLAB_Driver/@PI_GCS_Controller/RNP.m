function RNP(c,iPIEZOWALKChannelsArray,dInValues)
%   DESCRIPTION
%   "Relax" the piezos of a given PiezoWalk channel without motion. 
%
%   SYNTAX
%       PIdevice.RNP(c,iPIEZOWALKChannelsArray,dInValues)
% 
%   INPUT
%       iPIEZOWALKChannelsArray (int array)         string with PiezoWalk channels
%
%       dInValues (double array)                    voltages which must be applied forthe PiezoWalk channels,
%                                                   must be 0 to set the voltages to 0 V
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
