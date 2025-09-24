function FPL(c,szAxes)
%   DESCRIPTION
%   Starts a reference move: Moves all axes szAxes synchronously to the positive physical limits of their travel 
%   ranges and sets the current positions to the positive range limit values.
%   Note: Call IsControllerReady() to find out if referencing is complete (the controller will be "busy" while 
%   referencing, so most other commands will cause a PI_CONTROLLER_BUSY error) and qFRF() to 
%   check whether the reference move was successful.
%
%   SYNTAX
%       PIdevice.FPL(szAxes)
% 
%   INPUT
%       szAxes (char array)             axes to move
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
szAxes = ConvertCellArrayStringToString (szAxes);
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,szAxes);
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
