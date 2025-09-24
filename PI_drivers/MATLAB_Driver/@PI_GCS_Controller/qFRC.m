function [ sAnswer ] = qFRC ( c, szProcessIdBase )
%   DESCRIPTION
%   Fast alignment: Gets coupled fast alignment routines.
%
%   SYNTAX
%       [sAnswer] = PIdevice.qFRC(szProcessIdBase)
% 
%   INPUT
%       szProcessIdBase (char)              The identifier of the routine to be queried.
%
%   OUTPUT
%       [sAnswer] (char array)              buffer to receive the string read in from controller,
%                                           lines are separated by '\n' ("line-feed"). 
%                                           Contains the identifiers of routines that are coupled
%                                           to the routine given by szProcessIdBase.
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];

len = GetNrAxesInString ( c, szProcessIdBase );
if(len == 0)
    return;
end

if(any(strcmp(functionName,c.dllfunctions)))
    szAnswer = blanks ( 10001 );
	try
        [ bRet, ~, sAnswer ] = calllib ( c.libalias, functionName, c.ID, szProcessIdBase, szAnswer, 10000 );
		if(bRet==0)
			iError = GetError(c);
			szDesc = TranslateError(c,iError);
			error(szDesc);
		end
	catch
		rethrow(lasterror)
	end
else
	error('%s not found',functionName);
end
