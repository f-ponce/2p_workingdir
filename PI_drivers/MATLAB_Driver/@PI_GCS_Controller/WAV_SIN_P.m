function WAV_SIN_P(c,WaveTableId, OffsetOfFirstPointInWaveTable, NumberOfPoints, AddAppendWave, CenterPointOfWave, AmplitudeOfWave, OffsetOfWave, SegmentLength)
%   DESCRIPTION
%   Define sine curve for given wave table. 
%   To allow for flexible waveform shapes, a wave table can be divided into "segments". Each segment must 
%   be defined with a separate call of WAV_SIN_P() or one of the other WAV functions. In doing so, the 
%   iAppendWave argument (see below) is used to concatenate the segments so that they will form the final 
%   waveform. To change individual segments or to modify their order, the complete waveform must be 
%   recreated segment-by-segment. See the user manual of the controller for more information and for more 
%   examples.
%
%   SYNTAX
%       PIdevice.WAV_SIN_P(WaveTableId, OffsetOfFirstPointInWaveTable, NumberOfPoints, AddAppendWave, CenterPointOfWave, AmplitudeOfWave, OffsetOfWave, SegmentLength)
% 
%   INPUT
%       WaveTableId (int)                           The wave table ID
%
%       OffsetOfFirstPointInWaveTable (int)         The index of the starting point of the curve in the segment. Gives the phase shift. Lowest possible value is 0.                 
%
%       NumberOfPoints (int)                        The length of the curve as number of points. 
%
%       AddAppendWave (int)                         Possible values (supported values depend on controller):
%                                                   0 = clears the wave table and starts writing with the first point in the table
%                                                   1 = adds the content of the defined segment to the already existing wave table contents (i.e. the 
%                                                     values of the defined points are added to the existing values of that points)
%                                                   2 =  appends the defined segment to the already existing wave table content (i.e. concatenates 
%                                                     segments to form one final waveform) 
%
%       CenterPointOfWave (int)                     The index of the center point of the sine curve.
%                                                   Determines if the curve is symmetrically or not. Lowest possible value is 0.
%
%       AmplitudeOfWave (double)                    The amplitude of the sine curve. 
%
%       OffsetOfWave (double)                       The offset of the sine curve. 
%
%       SegmentLength (int)                         The length of the wave table segment as number of points. Only the number of 
%                                                   points given by iSegmentLength will be written to the wave table. If the iSegmentLength value is 
%                                                   larger than the iNumberOPoints value, the missing points in the segment are filled up with the 
%                                                   endpoint value of the curve.
%             
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT � PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName, c.dllfunctions)))
    try
		[bRet] = calllib(c.libalias, functionName, c.ID, WaveTableId, OffsetOfFirstPointInWaveTable, NumberOfPoints, AddAppendWave, CenterPointOfWave, AmplitudeOfWave, OffsetOfWave, SegmentLength);
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
