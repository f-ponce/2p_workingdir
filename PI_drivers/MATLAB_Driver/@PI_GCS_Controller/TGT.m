function TGT ( c, iTrajectoryTiming )
%   DESCRIPTION
%   Command for motion paths: Sets the timing for trajectories.
%   The timing specifies the time interval at which the individual points are output during the execution of the 
%   trajectories.
%   The specified value is valid for all trajectories.
%   NOTICE:
%   The controller does not calculate a dynamics profile during the execution of a trajectory. After the last 
%   trajectory point has been reached, the motion of the axis is abruptly stopped. This holds true for the proper 
%   completion of trajectories as well as for their cancellation (e. g., by a stop command or error). Acceleration 
%   / deceleration, velocity, and steadiness of the motion therefore depend on the following factors during 
%   trajectory execution:
%   -  Values of the trajectory points
%   -  Timing for the trajectories
%   -  Sufficiently fast refilling of the trajectory buffer
%   The execution of an unsuitable trajectory can cause the positioner to oscillate or the motion to abruptly 
%   stop.  Oscillations  or abrupt stopping can damage the positioner and/or the load affixed to it. Therefore, 
%   observe the following when working with trajectories:
%   -  The path that is specified by the trajectory points must be continuously differentiable at least twice.
%   -  During the execution of the trajectory, the maximum permissible velocity and acceleration of the 
%   axis must not be exceeded.
%   -  During the execution of the trajectory, an abrupt stop must not damage the load on the positioner.
%   -  To generate the trajectory points and continuously transfer them to the controller during the 
%   trajectory execution, it is recommended to use a suitable program.
%   For further information, see "Trajectories for Motion Paths" and the description of the TGT command in the 
%   documentation of your controller.
%
%   SYNTAX
%       PIdevice.TGT(iTrajectoryTiming)
% 
%   INPUT
%       iTrajectoryTiming (int)         Time interval between the output of the individual points of a trajectory
%                                       (unit: Number of servo cycles)
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
        [ bRet ] = calllib ( c.libalias, functionName, c.ID, iTrajectoryTiming );
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
