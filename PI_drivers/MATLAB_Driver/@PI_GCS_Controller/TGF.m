function TGF ( c, iTrajectoriesArray )
%   DESCRIPTION
%   Command for motion paths: Completes the execution of the specified trajectory
%   TGF() must be called after the last trajectory point has been loaded. If the trajectory execution is not 
%   properly completed with PI_TGF(), an error will occur when the number of points in the buffer falls below 
%   the required minimum (4).
%   A trajectory will only be executed as long as there are at least 4 points in the trajectory buffer. For 
%   trajectories to  be  executed to the end, this command must be sent after all trajectory points have been 
%   loaded. It signals to the firmware that no more points will be supplied for the specified trajectory. In this 
%   case, the remaining trajectory  points will  be processed without an error occurring when the minimum 
%   number of points is no longer present.
%   For further information, see "Trajectories for Motion Paths" and the description of the TGF command in the 
%   documentation of your controller.
%
%   SYNTAX
%       PIdevice.TGF(iTrajectoriesArray)
% 
%   INPUT
%       iTrajectoriesArray (int array)              array with the identifiers of the trajectories
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    piTrajectoriesArray = libpointer('int32Ptr', iTrajectoriesArray);
    iArraySize = length(iTrajectoriesArray);
	try
        [ bRet ] = calllib ( c.libalias, functionName, c.ID, piTrajectoriesArray, iArraySize );
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
