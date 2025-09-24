function nFreeSpace = MAC_qFREE(c)
%   DESCRIPTION
%   Gets the free memory space for macro recording. 
%   See "Controller Macros" and the MAC command description in the controller User Manual for details.
%
%   SYNTAX
%       nFreeSpace = PIdevice.MAC_qFREE
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    nFreeSpace = 0;
	pnFreeSpace = libpointer('int32Ptr',nFreeSpace);
	try
		[bRet,nFreeSpace] = calllib(c.libalias,functionName,c.ID,pnFreeSpace);
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
