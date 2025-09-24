function [movePossible] = qVMO(c, axes, positions)
%   DESCRIPTION
%   Checks whether the moving platform of the Hexapod can approach a specified 
%   position from the current position. qVMO() does not trigger any motion.
%
%   SYNTAX
%       [movePossible] = PIdevice.qVMO(axes, positions)
% 
%   INPUT
%       axes (char array)               string with axes
%
%       positions (double array)        array of target positions
%
%   OUTPUT
%       [movePossible] (int array)      value to receive, indicates whether the moving platform
%                                       can approach the position resulting from the given target position values:
%                                         0 = specified position cannot be approached
%                                         1 = specified position can be approached
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0),error('The controller is not connected'), end;

szAxes = axes
functionName = [ c.libalias, '_', mfilename];

if(any(strcmp(functionName,c.dllfunctions)))
	pdValues = libpointer('doublePtr', positions);
    movePossible = zeros(1,1);
	piMovePossible = libpointer('int32Ptr',movePossible);
	try
		[bRet, ~, ~, movePossible] = calllib(c.libalias, functionName, c.ID, szAxes, pdValues, piMovePossible);
		if(bRet==0)
			iError = GetError(c);
			szDesc = TranslateError(c,iError);
			error(szDesc);
		end
    catch ME
        error (ME.message);
	end
else
	error('%s not found',functionName);
end

movePossible = movePossible==1;