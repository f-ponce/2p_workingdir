function FRP ( c, szScanRoutineNames, iRoutineActionsArray )
%   DESCRIPTION
%   Fast alignment: Stops, pauses or resumes a fast alignment routine. A routine to be stopped or paused 
%   must have been started with PI_FRS before. A routine to be resumed with FRP must have been 
%   paused with FRP before.
%
%   SYNTAX
%       PIdevice.FRP(szScanRoutineNames, iRoutineActionsArray)
% 
%   INPUT
%       szScanRoutineNames (char array)         identifier of the routine
%
%       iRoutineActionsArray (int)              The action to be performed for the routine. 
%                                               Possible actions:
%                                               0 = stop the routine
%                                               1 = pause the routine
%                                               2 = resume the routine
%
%   PI MATLAB Class Library Version 1.5.0   
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    piRoutineActionsArray = libpointer ( 'int32Ptr', iRoutineActionsArray );
	try
        [bRet] = calllib ( c.libalias, functionName, c.ID, szScanRoutineNames, piRoutineActionsArray );
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
