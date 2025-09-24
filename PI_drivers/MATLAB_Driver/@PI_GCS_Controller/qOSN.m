function [iOutValues] = qOSN(c,iInValues)
%   DESCRIPTION
%   Reads the number of steps still to be performed for the given PiezoWalk channel after the last call of OSM().
%
%   SYNTAX
%       [iOutValues] = PIdevice.qOSN(iInValues)
% 
%   INPUT
%       iInValues (int array)           array with PiezoWalk channels
%
%   OUTPUT
%       [iOutValues] (double array)     array to receive the number of steps which are still to be performed
%                                       for open-loop step moving of the given PiezoWalk channels 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piValues = libpointer('int32Ptr',iInValues);
	iOutValues = zeros(size(iInValues));
	piOutValues = libpointer('int32Ptr',iOutValues);
	nValues = length(iInValues);
	try
		[bRet,~,iOutValues] = calllib(c.libalias,functionName,c.ID,piValues,piOutValues,nValues);
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
