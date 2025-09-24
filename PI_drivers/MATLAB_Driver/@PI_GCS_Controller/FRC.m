function FRC ( c, szProcessIdBase, szProcessIdsCoupled )
%   DESCRIPTION
%   Fast alignment: Couples fast alignment routines to each other.
%   Routine types that can be coupled: gradient search routines. Coupled routines are not allowed to stop until 
%   all routines coupled to them are finished.
%
%   SYNTAX
%       PIdevice.(szProcessIdBase, szProcessIdsCoupled)
% 
%   INPUT
%       szProcessIdBase (char array)        The identifier of a routine
%
%       szProcessIdsCoupled (char array)    The identifier of a routine that is to be coupled
%                                           to the routine given by szProcessIdBase
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
        [bRet] = calllib ( c.libalias, functionName, c.ID, szProcessIdBase, szProcessIdsCoupled );
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
