function ONL(c,iPiezoCannels,iValues)
%   DESCRIPTION
%   Sets control mode for given piezo channel (ONLINE or OFFLINE mode).
%
%   SYNTAX
%       PIdevice.ONL(iPiezoCannels,iValues)
% 
%   INPUT
%       iPiezoCannels (int array)       array with piezo channels
%
%       iValues (int array)             gives the control mode, can have the following values:
%                                       0 = OFFLINE mode, the output voltage depends on analog 
%                                           control input and DC offset applied to the channel
%                                       1 = ONLINE mode, the controller controls the generation 
%                                           of the output voltage In ONLINE mode the SERVO switches
%                                           of all channels must be set to OFF on the piezo control
%                                           electronics.
%    
%   PI MATLAB Class Library Version 1.5.0  
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piPiezoCannels = libpointer('int32Ptr',iPiezoCannels);
	piValues = libpointer('int32Ptr',iValues);
	nValues = length(iPiezoCannels);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,piPiezoCannels,piValues,nValues);
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
