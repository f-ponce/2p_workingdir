function FSC(c,szAxis1,dLength1,szAxis2,dLength2,dThreshold,dDistance,iAnalogInput)
%   DESCRIPTION
%   Starts a scanning procedure which scans a specified area ("scanning area") until the analog input signal 
%   reaches a specified intensity threshold. The scanning procedure started with FSC() corresponds to the
%   "coarse portion" of the scanning procedure that is started with the FSA function.
%
%   SYNTAX
%       PIdevice.FSC(szAxis1,dLength1,szAxis2,dLength2,dThreshold,dDistance,iAnalogInput)
% 
%   INPUT
%       szAxis1 (char)                  the axis in which the platform moves from scanning line to scanning line by the distance 
%                                       given by dDistance.
%
%       dLength1 (double)               length of scanning area along szAxis1
%
%       szAxis2 (char)                  is the axis in which the scanning lines are located
%
%       dLength2 (double)               length of scanning area along szAxis2
%
%       dThreshold (double)             intensity threshold of the analog input signal, in V
%
%       dDistance (double)              distance between the scanning lines
%
%       iAnalogInput (int)              is the identifier of the analog input signal whose maximum intensity is sought
%
%   PI MATLAB Class Library Version 1.5.0      
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,szAxis1,dLength1,szAxis2,dLength2,dThreshold,dDistance,iAnalogInput);
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
