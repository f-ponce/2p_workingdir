function CST(c,szAxes,szStageNasmes)
%   DESCRIPTION
%   Loads the specific values for the szStageNames positioner from a positioner database and sends them to the
%   controller so that the controller parameters are properly adjusted to the connected mechanics.
%   The permissible positioner types can be listed with the qVST() function. 
%   The following actions are included with CST():
%   -     Sets the servo off
%   -     Loads parameter values from positioner database and sends them to the controllers RAM using SPA()
%   -     Checks the error
%
%   C-887:
%   Note that the assignment of a positioner type with CST() is only permissible for axes A and B. The 
%   behavior of the function differs depending on the current versions of the controller firmware and PI GCS 2 
%   DLL. For further details, see PIGCS2 manual.
%
%   SYNTAX
%       PIdevice.CST(szAxes, szStageNames)
% 
%   INPUT
%       szAxes (char array)             identifiers of the axes
%
%       szStageNames (char array)       the name of the positioners separated by '\n' ("line-feed"), the names 
%                                       must be present in one of the positioner database files
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
szAxes = ConvertCellArrayStringToString (szAxes);
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,szAxes,szStageNasmes);
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
