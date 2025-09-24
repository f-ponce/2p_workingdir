function [ bValueArray ] = qFSR ( c, szAxis )
%   DESCRIPTION
%   Gets the result of the find-surface procedure initiated with FSF().
%
%   SYNTAX
%       [bValueArray] = PIdevice.qFSR(szAxis)
% 
%   INPUT
%       szAxis (char array)                 string with axes, if '', all axes are affected
%
%   OUTPUT
%       [bValueArray] (int array)           array to receive the results of the specified axes, 
%                                           TRUE for "successful",
%                                           FALSE for "procedure failed or still running" 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    bValueArray = 0;
    pbValueArray = libpointer ( 'int32Ptr', bValueArray );
	try
        [ bRet, ~, bValueArray ] = calllib ( c.libalias, functionName, c.ID, szAxis, pbValueArray );
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
