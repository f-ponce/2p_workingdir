function FLS(c,szAxis,dLength,dThreshold,iAnalogInput,iDirection)
%   DESCRIPTION
%   Starts a scanning procedure which scans a specified distance along an axis until the analog input signal 
%   reaches a specified intensity threshold.
%
%   SYNTAX
%       PIdevice.FLS(szAxis,dLength,dThreshold,iAnalogInput,iDirection)
% 
%   INPUT
%       szAxis  (char)          one axis of the controller, axes X, Y, Z, U, V, W are permissible
%
%       dLength  (double)       distance to be scanned along the axis
%
%       dThreshold (double)     intensity threshold of the analog input signal, in V
%
%       iAnalogInput (int)      is the identifier of the analog input signal whose maximum intensity is sought
%       
%       iDirection (int)        indicates the direction of the scanning procedure as well as the starting and
%                               end position of the distance
%  
%   PI MATLAB Class Library Version 1.5.0    
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
szAxis = ConvertCellArrayStringToString (szAxis);
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,szAxis,dLength,dThreshold,iAnalogInput,iDirection);
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
