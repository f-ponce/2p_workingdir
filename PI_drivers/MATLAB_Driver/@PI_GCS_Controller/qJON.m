function [iOutValues] = qJON(c,iInValues)
%   DESCRIPTION
%   Get activation state of the given joystick device which is directly connected to the controller.
%   See "Joystick Control" in the controller User Manual for details.
%
%   SYNTAX
%       [iOutValues] = PIdevice.qJON(iInValues) 
% 
%   INPUT
%       iInValues (int array)           array with joystick devices connected to the controller
%
%   OUTPUT
%       [iOutValues] (int array)        array to receive the joystick enable states (0 for deactivated, 1 for activated)
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
