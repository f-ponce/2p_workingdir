function TGC ( c, iTrajectoriesArray )
%   DESCRIPTION
%   Command for motion paths: Deletes the trajectory points in the buffer of the specified trajectory.
%   For further information, see "Trajectories for Motion Paths" and the description of the TGC command in 
%   the documentation of your controller.
%
%   SYNTAX
%       PIdevice.TGC(iTrajectoriesArray)
% 
%   INPUT
%       iTrajectoriesArray (int array)          array with the identifiers of the trajectories
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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
