function FSA(c,szAxis1,dLength1,szAxis2,dLength2,dThreshold,dDistance,dAlignStep,iAnalogInput)
%   DESCRIPTION
%   Starts a scanning procedure to determine the maximum intensity of an analog input signal in a plane. The 
%   search consists of two subprocedures:
%   - "Coarse portion"; corresponds to the procedure that is started with the PI_FSC() function
%   - "Fine portion"; corresponds to the procedure that is started with the PI_AAP() function
%   The fine portion is only executed when the coarse portion has previously been successfully completed.
%
%   SYNTAX
%       PIdevice.FSA/szAxis1,dLength1,szAxis2,dLength2,dThreshold,dDistance,dAlignStep,iAnalogInput)
% 
%   INPUT
%       szAxis1 (char)                      first axis that defines scanning area. Axes X, Y, and Z are permissible. 
%                                           During the coarse portion, the platform is moved in this axis from scanning
%                                           line to scanning line by the distance given by dDistance.
%
%       dLength1 (double)                   length of scanning area along szAxis1
%
%       szAxis2 (char)                      second axis that defines scanning area. Axes X, Y, and Z are permissible.
%                                           During the coarse portion, the scanning lines are in this axis.
%
%       dLength2 (double)                   length of scanning area along szAxis2
%
%       dThreshold (double)                 intensity threshold of the analog input signal, in V
%
%       dDistance (double)                  distance between the scanning lines, is only used during the coarse portion
%
%       dAlignStep (double)                 starting value for the step size, is only used during the fine portion
%
%       iAnalogInput (int)                  is the identifier of the analog input signal whose maximum intensity is sought
% 
%   PI MATLAB Class Library Version 1.5.0     
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,szAxis1,dLength1,szAxis2,dLength2,dThreshold,dDistance,dAlignStep,iAnalogInput);
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
