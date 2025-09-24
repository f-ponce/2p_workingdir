function [iConnecting] = IsConnecting(c,threadID)
%   DESCRIPTION
%   Check if thread with given ID is running trying to establish communication.
%
%   SYNTAX
%       [iConnecting] = PIdevice.IsConnecting(threadID, iConnecting)
% 
%   INPUT
%       threadID (int)              Thread ID
%
%       iConnecting (int)           empty int variable 
%
%   OUTPUT
%       iConnecting (int)           1 if thread is running
%                                   0 if no thread is running with given ID
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piConnecting = libpointer('int32Ptr', 0);
	try
		[bRet,iConnecting] = calllib(c.libalias,functionName,threadID,piConnecting);
		if(bRet<0)
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
