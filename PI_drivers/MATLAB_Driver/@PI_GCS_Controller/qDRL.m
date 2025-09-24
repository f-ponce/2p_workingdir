function [iOutValues] = qDRL(c,iInValues)
%   DESCRIPTION
%   Reads the number of points comprised by the last recording, i.e. the number of values that have been 
%   recorded since data recording was last triggered. This way it is possible to find out if recording has been 
%   finished (all desired points are in the record table) or to find out how many points can be currently read 
%   from the record table. Depending on the controller, reading more points than the number returned by 
%   qDRL can also read old record table content.
%
%   SYNTAX
%       [iOutValues] = PIdevice.qDRL(iInValues)
% 
%   INPUT
%       iInValues (int array)           array of the record channel IDs
%
%   OUTPUT
%       [iOutValues] (int array)        array to receive the number of values that have been recorded 
%                                       since recording was last triggered or PI_DRC() was called for the record channel
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
