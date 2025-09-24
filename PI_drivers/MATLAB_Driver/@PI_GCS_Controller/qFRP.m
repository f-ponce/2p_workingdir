function [iRoutineActionsArray] = qFRP ( c, szScanRoutineNames )
%   DESCRIPTION
%   Fast alignment: Gets the current state of a fast alignment routine.
%
%   SYNTAX
%       [iRoutineActionsArray] = qFRP(szScanRoutineNames)
% 
%   INPUT
%       szScanRoutineNames (char array)         the identifier of the routine
%
%   OUTPUT
%       [iRoutineActionsArray] (int array)      is the current state of the routine. Possible states:
%                                                 0 = routine has been stopped / is not running
%                                                 1 = routine has been paused
%                                                 2 = routine is running
%                                                 If no routine ID is given, the state of all routines is returned.
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];

len = GetNrAxesInString ( c, szScanRoutineNames );
if(len == 0)
    return;
end

if(any(strcmp(functionName,c.dllfunctions)))
    iRoutineActionsArray = zeros ( len, 1 );
    piRoutineActionsArray = libpointer ( 'int32Ptr', iRoutineActionsArray );

	try
        [ bRet, ~, iRoutineActionsArray ] = calllib ( c.libalias, functionName, c.ID, szScanRoutineNames, piRoutineActionsArray );
		if(bRet==0)
			iError = GetError(c);
			szDesc = TranslateError(c,iError);
			error(szDesc);
		end
	catch
		rethrow(lasterror)
	end
else
	error('%s not found',functionName);
end
