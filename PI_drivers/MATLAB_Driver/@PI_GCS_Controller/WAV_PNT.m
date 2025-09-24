function WAV_PNT(c,WaveTableId, OffsetOfFirstPointInWaveTable, NumberOfPoints, AddAppendWave, WavePoints)
%   DESCRIPTION
%   Create a user-defined curve for given wave table. 
%   To allow for flexible waveform shapes, a wave table can be divided into "segments". Each segment must 
%   be defined with a separate call of WAV_PNT() or one of the other WAV functions. In doing so, the 
%   iAppendWave argument (see below) is used to concatenate the segments so that they will form the final 
%   waveform. To change individual segments or to modify their order, the complete waveform must be 
%   recreated segment-by-segment. See the user manual of the controller for more information and for more 
%   examples.
%
%   SYNTAX
%       PIdevice.WAV_PNT(WaveTableId, OffsetOfFirstPointInWaveTable, NumberOfPoints, AddAppendWave, WavePoints)
% 
%   INPUT
%       WaveTableId (int)                               The ID of the wave table
%
%       OffsetOfFirstPointInWaveTable (int)             The index of the starting point. Must be 1. 
%
%       NumberOfPoints (int)                            The length of the user-defined curve as number of points. 
%
%       AddAppendWave (int)                             Possible values (supported values depend on controller):
%                                                       0 = clears the wave table and starts writing with the first point in the table
%                                                       1 = adds the content of the defined segment to the already existing wave table contents (i.e. the 
%                                                           values of the defined points are added to the existing values of that points)
%                                                       2 =  appends the defined segment to the already existing wave table content (i.e. concatenates 
%                                                           segments to form one final waveform)  
% 
%       WavePoints (double array)                       array with the wave points. 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName, c.dllfunctions)))
    pWavePoints = libpointer('doublePtr',WavePoints);
    try
		[bRet] = calllib(c.libalias, functionName, c.ID, WaveTableId, OffsetOfFirstPointInWaveTable, NumberOfPoints, AddAppendWave, pWavePoints );
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
