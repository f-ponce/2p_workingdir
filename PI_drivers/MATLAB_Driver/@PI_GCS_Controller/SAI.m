function SAI(c,sOldAxes,sNewAxes)
%   DESCRIPTION
%   Rename axes: szOldAxes will be set to szNewAxes. The characters in szNewAxes must not be in use for 
%   any other existing axes and must each be one of the valid identifiers. All characters in szNewAxes will be 
%   converted to uppercase letters. Only the last occurence of an axis identifier in szNewAxes will be used to 
%   change the name.
%
%   SYNTAX
%       PIdevice.SAI(sOldAxes,sNewAxes)
% 
%   INPUT
%       sOldAxes (char array)           old axis identifiers
%
%       sNewAxes (char array)           new identifiers for the axes 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,sOldAxes, sNewAxes);
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
