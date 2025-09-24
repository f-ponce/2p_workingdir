function MRW(c, szAxes, dValues)
%   DESCRIPTION
%   Move szAxes relative to current position and orientation in Work coordinate system. Position and 
%   orientation of the Work coordinate system do NOT change with motions of the platform.
%
%   SYNTAX
%       PIdevice.MRW(szAxes, dValues)
% 
%   INPUT
%       szAxes (char array)             string with axes
%
%       dValues (double array)          amounts to be added (algebraically) to current target positions of the axes
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
AssertValueVectorSize( c, szAxes, dValues )
functionName = [ c.libalias, '_', mfilename];
szAxes = ConvertCellArrayStringToString (szAxes);
if(any(strcmp(functionName,c.dllfunctions)))
	pdValues = libpointer('doublePtr',dValues);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,szAxes,pdValues);
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
