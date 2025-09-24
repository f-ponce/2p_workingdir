function KSD(c, szNameOfCoordSystem, szAxes, ValueArray)
%   DESCRIPTION
%   This command defines a new KSD type coordinate system. The center of rotation can be changed with the 
%   coordinates X, Y, Z. The orientation of the coordinate system can be changed with the coordinates U, V, W.
%
%   SYNTAX
%       PIdevice.KSD(szNameOfCoordSystem, szAxes, ValueArray)
% 
%   INPUT
%       szNameOfCoordSystem (char array)            name of the coordinate system to be defined
%
%       szAxes (char array)                         string with axes 
%
%       ValueArray (double array)                   positions (for axes X, Y, Z) and angles (for axes U, V, W)
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT � PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functionName = [ c.libalias, '_', mfilename];
szAxes = ConvertCellArrayStringToString (szAxes);
if(any(strcmp(functionName,c.dllfunctions)))
    pdValueArray = libpointer('doublePtr', ValueArray);
	try
        [bRet] = calllib (c.libalias, functionName, c.ID, szNameOfCoordSystem, szAxes, pdValueArray);
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
