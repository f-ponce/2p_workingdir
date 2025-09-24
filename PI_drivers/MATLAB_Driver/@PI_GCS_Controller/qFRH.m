function [ sAnswer ] = qFRH ( c )
%   DESCRIPTION
%   Fast alignment: Lists descriptions and physical units for 
%   the routine results that can be queried with qFRR().
%
%   SYNTAX
%       [sAnswer] = PIdevice.qFRH()
%
%   OUTPUT
%       [sAnswer] (char array)          buffer to receive the string read in from controller,
%                                       lines are separated by '\n' ("line-feed")
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];



if(any(strcmp(functionName,c.dllfunctions)))
    szAnswer = blanks ( 10001 );
	try
        [ bRet, sAnswer ] = calllib ( c.libalias, functionName, c.ID, szAnswer, 10000 );
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
