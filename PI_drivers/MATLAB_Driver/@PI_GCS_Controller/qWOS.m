function [dOutValues1] = qWOS(c,iInValues1)
%   DESCRIPTION
%   Reads the current value of the offset which is added to the wave generator output.
%
%   SYNTAX
%       [dOutValues1] = PIdevice.qWOS(iInValues1)
% 
%   INPUT
%       iInValues1 (int array)              array with wave generators
%
%   OUTPUT
%       [dOutValues1] (double array)        array to receive the offsets of the wave generators.
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT � PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piInValues1 = libpointer('int32Ptr',iInValues1);
	nValues = length(iInValues1);
	dOutValues1 = zeros(size(iInValues1));
	pdOutValues1 = libpointer('doublePtr',dOutValues1);
	try
		[bRet,~,dOutValues1] = calllib(c.libalias,functionName,c.ID,piInValues1,pdOutValues1,nValues);
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
