function CancelConnect(c,iThreadID)
%   DESCRIPTION
%   Cancel connecting thread with given thread ID
%
%   SYNTAX
%       PIdevice.CancelConnect(iThreadID)
% 
%   INPUT
%       iThreadID               
% 
%   PI MATLAB Class Library Version 1.5.0     
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    [bRet] = calllib(c.libalias,functionName,iThreadID);
    if(bRet==0)
        error('no thread with given ID was running');           
    end     
else
	error('%s not found',functionName);
end
