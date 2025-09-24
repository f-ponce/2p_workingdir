function CPA(c,sourceMemType,targetMemType,containerUnit,functionUnit,parameter)
%   DESCRIPTION
%   
%   Copies parameter values form one memory type of the controller to another.
%   
%
%   SYNTAX
%        PIdevice.CPA(sourceMemType,targetMemType,containerUnit,functionUnit,parameter)
% 
%   INPUT
%       sourceMemType (char array)                Type of memory from which the values are to be copied   
%
%       targetMemType (char array)                Type of memory into which the values are to be copied
%
%       containerUnit (char array)                Container unit whose parameters are to be copied
%
%       functionUnit (char array)                 Function unit whose parameters are to be copied
%
%       parameter (char array)                    The value of this addressed parameter is copied into the specified memory.
% 
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end
sourceMemType = ConvertCellArrayStringToString (sourceMemType);
targetMemType = ConvertCellArrayStringToString (targetMemType);
containerUnit = ConvertCellArrayStringToString (containerUnit);
functionUnit = ConvertCellArrayStringToString (functionUnit);
parameter = ConvertCellArrayStringToString (parameter);
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,sourceMemType,targetMemType,containerUnit,functionUnit,parameter);
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