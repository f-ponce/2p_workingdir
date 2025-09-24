function [iTrajectoryTiming] = qTGT ( c )
%   DESCRIPTION
%   Command for motion paths: Queries the timing for trajectories. The returned value is valid for all trajectories.
%   For further information, see "Trajectories for Motion Paths" and the description of the TGT? command in 
%   the documentation of your controller.
%
%   SYNTAX
%       [iTrajectoryTiming] = PIdevice.qTGT()
%
%   OUTPUT
%       [iTrajectoryTiming] (int)       Time interval between the output of the
%                                       individual points of a trajectory (unit: Number of servo cycles)
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    iTrajectoryTiming = 0;
    piTrajectoryTiming = libpointer ( 'int32Ptr', iTrajectoryTiming );
	try
        [ bRet, iTrajectoryTiming ] = calllib ( c.libalias, functionName, c.ID, piTrajectoryTiming );
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
