function KLD(c, szNameOfCoordSystem, szAxes, ValueArray)
%   DESCRIPTION
%   Defines a levelling coordinate system (KLD type). A coordinate system defined with KLD is intended to 
%   eliminate Hexapod misalignment. Use KLD in case misalignment is known via an external measurable 
%   deviation.
%
%   SYNTAX
%       PIdevice.KLD(szNameOfCoordSystem, szAxes, ValueArray)
% 
%   INPUT
%       szNameOfCoordSystem (char array)    name of the coordinate system to be defined
%
%       szAxes (char array)                 string with axes
%
%       ValueArray (double array)           positions (for axes X, Y, Z) and angles (for axes U, V, W)
%    
%   PI MATLAB Class Library Version 1.5.0  
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
