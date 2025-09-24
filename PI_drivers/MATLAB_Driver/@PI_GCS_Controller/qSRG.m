function [iOutValues1] = qSRG(c,szAxes,iInValues1)
%   DESCRIPTION
%   Returns register values for queried axes and register numbers. 
%
%   SYNTAX
%       [iOutValues1] = PIdevice.qSRG(szAxes,iInValues1)
% 
%   INPUT
%       szAxes (char array)         axis for which the register values should be read
%
%       iInValues1 (int array)      IDs of registers
%
%   OUTPUT
%       [iOutValues1] (int array)   array to be filled with the values for the registers. 
%                                   The answer is bit-mapped and returned as the sum of the individual codes, 
%                                   in hexadecimal format.
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piInValues1 = libpointer('int32Ptr',iInValues1);
	iOutValues1 = zeros(size(iInValues1));
	piOutValues1 = libpointer('int32Ptr',iOutValues1);
	try
		[bRet,~,~,iOutValues1] = calllib(c.libalias,functionName,c.ID,szAxes,piInValues1,piOutValues1);
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
