function DPO(c,szAxes)
%   DESCRIPTION
%   Dynamic Digital Linearization (DDL) Parameter Optimization. Recalculates the internal DDL processing 
%   parameters (Time Delay Max, ID 0x14000006, Time Delay Min, ID 0x14000007) for specified axis.
%
%   SYNTAX
%       PIdevice.DPO(szAxes)
% 
%   INPUT
%       szAxes (char array)             string with axes, if '', all axes are affected
%  
%   PI MATLAB Class Library Version 1.5.0    
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
szAxes = ConvertCellArrayStringToString (szAxes);
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,szAxes);
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
