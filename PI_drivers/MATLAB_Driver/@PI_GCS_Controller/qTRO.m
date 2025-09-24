function [iOutValues1] = qTRO(c,iValues1)
%   DESCRIPTION
%   Returns if the trigger output configuration made with CTO()
%   is enabled or disabled for the given digital output line.
%
%   SYNTAX
%       [iOutValues1] = PIdevice.qTRO(iValues1)
% 
%   INPUT
%       iValues1 (int array)            digital output lines of the controller
%
%   OUTPUT
%       [iOutValues1] (int array)       the current states of the digital output lines:
%                                         0 = Trigger output disabled
%                                         1 = Trigger output enabled
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piValues1 = libpointer('int32Ptr',iValues1);
	iOutValues1 = zeros(size(iValues1));
	piOutValues1 = libpointer('int32Ptr',iOutValues1);
	nValues = length(iValues1);
	try
		[bRet,~,iOutValues1] = calllib(c.libalias,functionName,c.ID,piValues1,piOutValues1,nValues);
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
