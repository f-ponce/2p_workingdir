function KSB(c, szNameOfCoordSystem, szAxes, ValueArray)
%   DESCRIPTION
%   Defines a new coordinate system of KSB type by changing the orientation of the base coordinate system
%   (possible in steps of 90°).
%
%   SYNTAX
%       PIdevice.KSB(szNameOfCoordSystem, szAxes, ValueArray)
% 
%   INPUT
%       szNameOfCoordSystem (char array)        name of the coordinate system to be defined
%
%       szAxes (char array)                     string with axes, possible values are U, V, W
%
%       ValueArray (double array)               angles in degrees, possible values are 0, 90, 180, 270, -90, -180, -270
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functionName = [ c.libalias, '_', mfilename];
szAxes = ConvertCellArrayStringToString (szAxes);
if(any(strcmp(functionName,c.dllfunctions)))
    pdValueArray = libpointer('doublePtr', ValueArray);
	try
        [bRet] = calllib(c.libalias, functionName, c.ID, szNameOfCoordSystem, szAxes, pdValueArray);
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
