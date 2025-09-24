function [dOutValues] = ReadGCS30Array(c,header, ppdData)
% This code is provided by Physik Instrumente(PI) GmbH&Co.KG
% You may alter it corresponding to your needs
% Comments and Corrections are very welcome
% Please contact us by mailing to support-software@pi.ws

   
headerlines = regexp ( header,'\n','split' );

sampletime   = -1;
timeColumnIndex = -1;

for n = 1:length(headerlines)
    currentline = headerlines{n};
    if(~isempty(strfind(currentline,'DIM')))
        nTables = str2num(currentline(strfind(currentline,'=')+1:end));
    end
    if(~isempty(strfind(currentline,'NDATA')))
        numberOfPoints = str2num(currentline(strfind(currentline,'=')+1:end));
    end
    if(~isempty(strfind(currentline,'SAMPLE_TIME')))
        sampletime = str2double(currentline(strfind(currentline,'=')+1:end));
    end;
    if(~isempty(strfind(currentline,'TIME')) && ~isempty(strfind(currentline,'NAME')))
        number = currentline( (strfind(currentline,'NAME') + 4):( strfind(currentline,'=') -1));
        timeColumnIndex = str2num(number) + 1;
    end
end

%% Parse GCS-Array Data

% Wait until all Data is received
numberOfDatapoints = 0;
while ( numberOfDatapoints < ( nTables * numberOfPoints ) )
    pause ( 0.1 );
    numberOfDatapoints =  GetAsyncBufferIndex ( c );
end

setdatatype ( ppdData,'doublePtr', nTables, numberOfPoints );
dOutValues = ppdData.Value';
