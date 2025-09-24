function [pdValueArray] = qTRA (c, szAxes, Components)
%   DESCRIPTION
%   This command returns the maximum absolute position which can be reached from the current position in 
%   the given direction for the queried axis vector.
%
%   SYNTAX
%       [pdValueArray] = PIdevice.qTRA(szAxes, Components)
% 
%   INPUT
%       szAxes (char array)                 string with axes
%
%       Components (double array)           components of the vector
%
%   OUTPUT
%       [pdValueArray] (double array)       array to receive maximum positions of the axes 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    axesSplitted = regexp(szAxes,'[\w]+','match');
    numberOfAxes = length(axesSplitted);

    if (numberOfAxes  ~=  length (Components) )
        error('The number of axes and components must be the same');
    end
    
    pdComponents = libpointer ('doublePtr', Components);
    ValueArray      = zeros (1, numberOfAxes );
    pdValueArray    = libpointer ('doublePtr', ValueArray);
	try
        [bRet, ~, ~, pdValueArray] = calllib (c.libalias, functionName, c.ID, szAxes, pdComponents, pdValueArray);
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

