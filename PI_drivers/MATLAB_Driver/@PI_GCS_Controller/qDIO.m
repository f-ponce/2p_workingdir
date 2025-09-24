function [iOutValues1] = qDIO(c,iValues1)
%   DESCRIPTION
%   Returns the states of the specified digital input channels.
%   Use qTIO() to get the number of installed digital I/O channels.
%
%   SYNTAX
%       [iOutValues1] = PIdevice.qDIO(iValues1)
% 
%   INPUT
%       iValues1 (int array)        array containing digital output channel identifiers
%
%   OUTPUT
%       [iOutValues1] (int array)   array containing the states of specified digital ouput channels,
%                                   TRUE if HIGH, FALSE if LOW
%                                   Depending on the controller, piChannelsArray can contain 0.
%                                   In this case, the array is a bit pattern which gives the states of all lines.
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
