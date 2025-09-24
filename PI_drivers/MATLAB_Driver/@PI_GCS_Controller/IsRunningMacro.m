function [iOutValues1] = IsRunningMacro(c)
%   DESCRIPTION
%   Check if controller is currently running a macro
%
%   SYNTAX
%       [iOutValues1] = PIdevice.IsRunningMacro()
% 
%   OUTPUT
%       [iOutValues1] (int array)           array to receive answer:      
%                                           1 if a macro is running, 0 otherwise
%     
%   PI MATLAB Class Library Version 1.5.0 
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	iOutValues1 = zeros(1);
	piOutValues1 = libpointer('int32Ptr',iOutValues1);
	try
		[bRet,iOutValues1] = calllib(c.libalias,functionName,c.ID,piOutValues1);
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
