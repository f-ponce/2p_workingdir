function [iValues] = IsGeneratorRunning(c,iWaveGeneratorIds)
%   DESCRIPTION
%   Check if wave generators are running. If TRUE (1) for a wave generator, the corresponding element of the 
%   array will be set to TRUE (1), otherwise to FALSE (0). If no wave generators were specified, only one boolean 
%   value is set and it is placed in iValues: It is TRUE (1) if at least
%   one wave generator is TRUE (1), FALSE (0) otherwise. 
%
%   SYNTAX
%       [iValues] = IsGeneratorRunning(iWaveGeneratorsIds)
% 
%   INPUT
%       iWaveGeneratorsIds (int array)      string with wave generator IDs, if no parameters were passed, all wave generators are 
%                                           queried and a global result placed in iValues.
%
%   OUTPUT
%       [iValues] (int array)               array to receive status of the wave generators, 1 for wave generator in progress,  
%                                           0 otherwise 
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FunctionName = 'PI_IsGeneratorRunning';
if(any(strcmp(FunctionName,c.dllfunctions)))
    piWaveGeneratorIds = libpointer('int32Ptr',iWaveGeneratorIds);
    nValues = length(iWaveGeneratorIds);
    iValues = zeros(nValues,1);
    piValues = libpointer('int32Ptr',iValues);
    
    try
        [bRet,~,iValues] = calllib(c.libalias,FunctionName,c.ID,piWaveGeneratorIds,piValues,nValues);
        if(bRet==0)
            iError = GetError(c);
            szDesc = TranslateError(c,iError);
            error(szDesc);
        end
    catch
        rethrow(lasterror);
    end
else
    error('%s not found',FunctionName);
end