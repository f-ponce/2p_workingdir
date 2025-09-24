function [szAnswer] = qMOD(c,szItems,uiModeArray)
%   DESCRIPTION
%   Get modes for axes / channels / system.
%
%   SYNTAX
%       [szAnswer] = PIdevice.qMOD(szItems,uiModeArray)
% 
%   INPUT
%       szItems (char array)        string with item identifiers
%
%       uiModeArray (int array)     array with IDs of modes to be queried
%
%   OUTPUT
%       [szAnswer] (char array)     string to be filled with values for each mode
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	szAnswer = blanks(2049);
	try
		[bRet,~,~,szAnswer] = calllib(c.libalias,functionName,c.ID,szItems,uiModeArray,szAnswer,2048);
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
