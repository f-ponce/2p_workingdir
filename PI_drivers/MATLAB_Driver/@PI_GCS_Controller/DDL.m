function DDL(c,TableNr,StartIndex,Values)
%   DESCRIPTION
%   Transfer dynamic digital linearization feature data to a DDL data table on the controller. 
%
%   SYNTAX
%       PIdevice.DDL(TableNr,StartIndex,Values)
% 
%   INPUT
%       TableNr (int)               number of the DDL data table to use
%
%       StartIndex (int)            index of first value to be transferred, (the first value in the DDL table has index 1)
%
%       Values (int)                number of values to be transferred
%  
%   PI MATLAB Class Library Version 1.5.0    
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	pdValues = libpointer('doublePtr',Values);
	nValues = length(Values);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,TableNr,StartIndex,nValues,pdValues);
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
