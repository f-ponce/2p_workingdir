function WCL ( c, iWaveTableIdsArray )
%   DESCRIPTION
%   Clears the content of the given wave table.
%   As long as a wave generator is running, it is not possible to delete the connected wave table.
%
%   SYNTAX
%       PIdevice.WCL(iWaveTableIdsArray)
% 
%   INPUT
%       iWaveTableIdsArray (int array)       array with the IDs of the wave tables to be cleared.
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;

functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    piWaveTableIdsArray = libpointer( 'int32Ptr', iWaveTableIdsArray );
    iNumberOfParameters = length ( iWaveTableIdsArray );
	try
        [bRet] = calllib ( c.libalias, functionName, c.ID, piWaveTableIdsArray, iNumberOfParameters );
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
