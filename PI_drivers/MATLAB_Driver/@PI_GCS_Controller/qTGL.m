function [iTrajectorySizesArray] = qTGL ( c, iTrajectoriesArray )
%   DESCRIPTION
%   Command for motion paths: Queries the number of points in the buffer of the specified trajectory.
%   For further information, see "Trajectories for Motion Paths" and the description of the TGL? command in 
%   the documentation of your controller.
%
%   SYNTAX
%       [iTrajectorySizesArray] = PIdevice.qTGL(iTrajectoriesArray)
% 
%   INPUT
%       iTrajectoriesArray (int array)          Array with identifiers of the trajectories
%
%   OUTPUT
%       [iTrajectorySizesArray] (int array)     Array with the current number of points in the buffer of the trajectories
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    piTrajectoriesArray = libpointer('int32Ptr', iTrajectoriesArray);
    iTrajectorySizesArray = zeros(size(iTrajectoriesArray));
    piTrajectorySizesArray = libpointer('int32Ptr', iTrajectorySizesArray);
    iArraySize = length(iTrajectoriesArray);
	try
        [ bRet, ~, iTrajectorySizesArray ] = calllib ( c.libalias, functionName, c.ID, piTrajectoriesArray, piTrajectorySizesArray, iArraySize );
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
