function TGA ( c, iTrajectoriesArray, dValarray )
%   DESCRIPTION
%   Command for motion paths: Loads trajectory points to the buffer of the specified trajectory.
%   Before a trajectory is executed, at least 4 points must be loaded to the trajectory buffer. The maximum 
%   number of points in the trajectory buffer is determined by the Maximum Buffer Size parameter (0x22000020).
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
%   stop. Oscillations or abrupt stopping can damage the positioner and/or the load affixed to it. Therefore, 
%   observe the following when working with trajectories:
%   -  The path that is specified by the trajectory points must be continuously differentiable at least twice.
%   -  During the execution of the trajectory, the maximum permissible velocity and acceleration of the 
%   axis must not be exceeded.
%   -  During the execution of the trajectory, an abrupt stop must not damage the load on the positioner.
%   -  To generate the trajectory points and continuously transfer them to the controller during the 
%   trajectory execution, it is recommended to use a suitable program.
%   For further information, see "Trajectories for Motion Paths" and the description of the TGA command in the 
%   documentation of your controller.
%
%   SYNTAX
%       PIdevice.TGA(iTrajectoriesArray, dValarray)
% 
%   INPUT
%       iTrajectoriesArray (int array)          array with the identifiers of the trajectories
%
%       dValarray (double array)                array with the values in FLOAT format; indicates a trajectory 
%                                               point as the absolute position in physical units
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    piTrajectoriesArray = libpointer('int32Ptr', iTrajectoriesArray);
    pdValarray = libpointer('doublePtr', dValarray);
    iArraySize = length(dValarray);
	try
        [ bRet ] = calllib ( c.libalias, functionName, c.ID, piTrajectoriesArray, pdValarray, iArraySize );
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
