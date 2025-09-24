function [iOutValues] = qONL(c,iInValues)
%   DESCRIPTION
%   Gets current control mode for iPiezoChannels.
%
%   SYNTAX
%       [iOutValues] = PIdevice.qONL(iInValues)
% 
%   INPUT
%       iInValues (int array)           string with piezo channels
%
%   OUTPUT
%       [iOutValues] (int array)        array to receive the control modes of the specified piezo channels,
%                                       1 for "ONLINE", 0 for "OFFLINE" 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
