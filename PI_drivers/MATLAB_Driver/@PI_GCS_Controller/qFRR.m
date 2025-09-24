function [szAnswer] = qFRR ( c, szScanRoutineName, iResultId )
%   DESCRIPTION
%   Fast alignment: Gets the results of a fast alignment routine. See the E712T0016 Technical Note for valid 
%   result identifiers and possible results. Use the response to qFRH() to get information on the supported 
%   result identifiers.
%
%   SYNTAX
%       [szAnswer] = PIdevice.qFRR(szScanRoutineName, iResultId)
% 
%   INPUT
%       szScanRoutineName (char array)      The identifier of the routine. If no routine identifier is given,
%                                           all available results are queried.
%
%       iResultId (int array)               The identifier of the result. If no result identifier is given,
%                                           all available results for the given routine are queried.
%
%   OUTPUT
%       [szAnswer] (char array)             buffer to receive the string read in from controller,
%                                           lines are separated by '\n' ("line-feed")
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    szAnswer = blanks ( 10001 );
	try
        [ bRet, ~,szAnswer ] = calllib ( c.libalias, functionName, c.ID, szScanRoutineName, iResultId, szAnswer, 10000 );
		if(bRet==0)
			iError = GetError(c);
			szDesc = TranslateError(c,iError);
			error(szDesc);
		end
	catch
		rethrow(lasterror)
	end
else
	error('%s not found',functionName);
end
