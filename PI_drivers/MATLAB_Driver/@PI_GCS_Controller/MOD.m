function MOD(c,szItems,uiModeArray,szValues)
%   DESCRIPTION
%   Set modes for axes / channels / system.
%
%   SYNTAX
%       PIdevice.MOD(szItems,uiModeArray,szValues)
% 
%   INPUT
%       szItems (char array)            string with item identifiers
%
%       uiModeArray (int array)         array with IDs of modes to be set
%
%       szValues (char array)           string with values for each mode to be set
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	puiModeArray = libpointer('uint32Ptr',uiModeArray);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,szItems,puiModeArray,szValues);
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
