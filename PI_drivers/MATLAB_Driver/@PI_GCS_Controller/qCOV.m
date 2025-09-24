function [pdValueArray] = qCOV(c,piChannelsArray)  
%   DESCRIPTION
%   
%   Get current open-loop velocity
%
%
%   SYNTAX
%        [pdValueArray] = PIdevice.qCOV(piChannelsArray)
% 
%   INPUT
%       piChannelsArray (int array)             array with the channels to be queried                             
%
%   OUTPUT
%       [pdValueArray] (double array)           array to receive the values            
%      
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    pdValueArray = zeros(1,1); 
	pdValueArray = libpointer('doublePtr',pdValueArray);
    piChannelsArray = libpointer('int32Ptr',piChannelsArray);
	try
		[bRet,~,pdValueArray] = calllib(c.libalias,functionName,c.ID,piChannelsArray,pdValueArray,length(piChannelsArray));
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