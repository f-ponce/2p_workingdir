function FIO(c,szAxis1,dLength1,szAxis2,dLength2,dThreshold,dLinearStep,dAngleScan,iAnalogInput)
%   DESCRIPTION
%   Starts a scanning procedure for the alignment of optical elements (e.g. optical fibers), the input and output 
%   of which are on the same side.
%
%   SYNTAX
%       PIdevice.FIO(szAxis1,dLength1,szAxis2,dLength2,dThreshold,dLinearStep,dAngleScan,iAnalogInput)
% 
%   INPUT
%       szAxis1 (char)          first axis that defines scanning area
%
%       dLength1 (double)       length of scanning area along szAxis1
%
%       szAxis2 (char)          second axis that defines scanning area
%
%       dLength2 (double)       length of scanning area along szAxis2
%
%       dThreshold (double)     intensity threshold of the analog input signal, in V
%
%       dLinearStep (double)    step size in which the platform moves along the spiral path
%
%       dAngleScan (double)     angle around the pivot point at which scanning is done, in degrees
%
%       iAnalogInput (int)      is the identifier of the analog input signal whose maximum intensity is sought
%   
%   PI MATLAB Class Library Version 1.5.0   
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,szAxis1,dLength1,szAxis2,dLength2,dThreshold,dLinearStep,dAngleScan,iAnalogInput);
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
