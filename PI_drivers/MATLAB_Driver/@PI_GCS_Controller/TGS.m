function TGS ( c, iTrajectoriesArray )
%   DESCRIPTION
%   Command for motion paths: Starts the execution of the specified trajectory or trajectories.
%   Before a trajectory is executed, at least 4 points must be loaded to the trajectory buffer with TGA(). 
%   During the execution of a trajectory, the buffer must be refilled fast enough. The execution of a trajectory 
%   must be completed with TGF()
%   For further information, see "Trajectories for Motion Paths" and the description of the TGS command in the 
%   documentation of your controller.
%
%   SYNTAX
%       PIdevice.TGS(iTrajectoriesArray)
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

functionName = ['PI_', mfilename];

% Method available?
if ( ~any ( strcmp ( functionName, c.dllfunctions ) ) ), error('Method %s not found',functionName), end;


% Create variables for C interface
piTrajectoriesArray = libpointer('int32Ptr', iTrajectoriesArray);
iArraySize = length(iTrajectoriesArray);


try
    % call C interface
    [ bRet ] = calllib ( c.libalias, functionName, c.ID, piTrajectoriesArray, iArraySize );
    
    if ( 0 == bRet )
        iError = GetError ( c );
        szDesc = TranslateError ( c, iError );
        error ( szDesc );
    end
    
catch ME
    error ( ME.message );
end