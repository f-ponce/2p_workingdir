function WFR (c,szAxis,iMode,dAmplitude,dLowFrequency,dHighFrequency,iNumberOfFrequencies)
%   DESCRIPTION
%   
%   Start an oscillation for a given frequency, amplitude, zero point and number of cycles and use the Goertzel
%   algorithm to determine the system response (magnitude and phase shift) for this frequency.
%   
%
%   SYNTAX
%        PIdevice.WFR (szAxis,iMode,dAmplitude,dLowFrequency,dHighFrequency,iNumberOfFrequencies)
% 
%   INPUT
%       szAxis (char array)                                 Name of axis to be commanded                         
%
%       iMode (int)                                         Zero point of oscillation
%
%       dAmplitude (int)                                    Amplitude of the oscillation
%
%       dLowFrequency (int)                                 Lowest frequency of the oscillation
%
%       dHighFrequency (int)                                Highest frequency of the oscillation
%
%       iNumberOfFrequencies (int)                          Number of frequencies between 'lowfrequency' and 'highfrequency'
%
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
szAxis = ConvertCellArrayStringToString (szAxis);

functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,szAxis,iMode,dAmplitude,dLowFrequency,dHighFrequency,iNumberOfFrequencies);
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