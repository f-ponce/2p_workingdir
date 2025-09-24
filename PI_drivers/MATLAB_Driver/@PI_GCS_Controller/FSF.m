function FSF ( c, szAxis, dForceValue1, dPositionOffset, iUseForceValue2, dForceValue2 )
%   DESCRIPTION
%   Starts a find-surface procedure. A find-surface procedure is recommended for axes that are to be 
%   operated in a force control mode. For procedure details, see the controller documentation.
%
%   SYNTAX
%       PIdevice.FSF(szAxis, dForceValue1, dPositionOffset, iUseForceValue2, dForceValue2)
% 
%   INPUT
%       szAxes (char)               string with ID of axis    
%
%       dForceVAlue1 (double)       is a force value as float. Default unit: gF.
%
%       dPositionOffset (double)    distance to be added to the found surface position, as float.
%
%       iUseForceValue2 (int)       specifies whether an automatic adaptation of feedforward settings
%                                   for force control is to be included in the find-surface procedure, 
%                                   1 for "yes", 0 for "no"
%
%       dForceValue2 (double)       is a force value as float. Default unit: gF.
%                                   Only used if automatic adaptation of feedforward settings is enabled.
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
szAxis = ConvertCellArrayStringToString (szAxis);
if(any(strcmp(functionName,c.dllfunctions)))
	try
        [ bRet ] = calllib ( c.libalias, functionName, c.ID, szAxis, dForceValue1, dPositionOffset, iUseForceValue2, dForceValue2 );
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
