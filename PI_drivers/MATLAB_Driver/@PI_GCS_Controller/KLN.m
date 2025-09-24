function KLN (c, szNameOfChild, szNameOfParent)
%   DESCRIPTION
%   Links two coordinate systems together by defining a parent-child relation; thus forming a chain.
%
%   SYNTAX
%       PIdevice.KLN(szNameOfChild, szNameOfParent)
% 
%   INPUT
%       szNameOfChild (char array)              name of the child coordinate system
%
%       szNameOfParent (char array)             name of the parent coordinate system
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
        [bRet] = calllib (c.libalias, functionName, c.ID, szNameOfChild, szNameOfParent);
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
