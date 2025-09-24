function [iNInputs,iNOutputs] = qTIO(c)
%   DESCRIPTION
%   Returns the number of available digital I/O channels.
%
%   SYNTAX
%       [iNInputs,iNOutputs] = PIdevice.qTIO()
%
%   OUTPUT
%       [iNInputs] (int)        variable to receive number of available digital input channels
%
%       [iNOutputs] (int)       variable to receive number of available digital output channels
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	iNInputs = zeros(1);
	iNOutputs = zeros(1);
	piNInputs = libpointer('int32Ptr',iNInputs);
	piNOutputs = libpointer('int32Ptr',iNOutputs);
	try
		[bRet,iNInputs,iNOutputs] = calllib(c.libalias,functionName,c.ID,piNInputs,piNOutputs);
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
