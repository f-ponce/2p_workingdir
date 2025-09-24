function [szAnswer] = qHIS(c)
%   DESCRIPTION
%   Gets the properties of the operating elements of HID devices connected to the controller.
%
%   SYNTAX
%       [szAnswer] = PIdevice.qHIS()
%
%   OUTPUT
%       [szAnswer] (char array)     buffer to receive the string read in from controller, 
%                                   lines are separated by '\n' ("line-feed") 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	szAnswer = blanks(10000);
	try
		[bRet,szAnswer] = calllib(c.libalias,functionName,c.ID,szAnswer,9999);
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
