function AAP(c,szAxis1,dLength1,szAxis2,dLength2,dAlignStep,iNrRepeatedPositions,iAnalogInput)
%   DESCRIPTION
%   Starts a scanning procedure for better determination of the maximum intensity of an analog input signal.
%   The scanning procedure started with AAP() corresponds to the "fine portion" of the scanning 
%   procedure that was started with FSA(). 
%
%   SYNTAX
%       PIdevice.AAP(szAxis1,dLength1,szAxis2,dLength2,dAlignStep,iNrRepeatedPositions,iAnalogInput)
% 
%   INPUT
%       szAxis1 (char array)        first axis that defines scanning area
%
%       dLength1 (double)           length of scanning area along szAxis1
%
%       szAxis2 (char array)        second axis that defines scanning area
%
%       dLength2 (double)           length of scanning area along szAxis2
%
%       dAlignStep (double)         starting value for the step size
%
%       iNrRepeatedPositions (int)  number of successful checks of the local maximum at the current position 
%                                   that is required for successfully completing
%
%       iAnalogInput (int)          is the identifier of the analog input signal whose maximum intensity is sought
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,szAxis1,dLength1,szAxis2,dLength2,dAlignStep,iNrRepeatedPositions,iAnalogInput);
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
