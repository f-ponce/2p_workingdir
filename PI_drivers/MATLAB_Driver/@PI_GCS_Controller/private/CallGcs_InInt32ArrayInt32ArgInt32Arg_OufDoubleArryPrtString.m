function [dOutValues, sHeader] = CallGcs_InInt32ArrayInt32ArgInt32Arg_OufDoubleArryPrtString(c,sGcsFunctionName, tabelIds, startPoint, numberOfPoints)
%function [dOutValues, sHeader] = CallGcs_InInt32ArrayInt32ArgInt32Arg_OufDoubleArryPrtString(c,sGcsFunctionName, tabelIds, startPoint, numberOfPoints)
% This code is provided by Physik Instrumente(PI) GmbH&Co.KG
% You may alter it corresponding to your needs
% Comments and Corrections are very welcome
% Please contact us by mailing to support-software@pi.ws

functionName = [ c.libalias, '_', sGcsFunctionName];
if(strmatch(functionName,c.dllfunctions))
    piTables = libpointer('int32Ptr',tabelIds);
    nTables = length(tabelIds);
    hlen = 2048;
    sHeader = blanks(hlen+1);
    
    ppdData = libpointer('doublePtr');
    try
        [bRet,~,ppdData,sHeader] = calllib(c.libalias,functionName,c.ID,piTables,nTables,startPoint,numberOfPoints,ppdData,sHeader,hlen);
        if(bRet==0)
            iError = GetError(c);
            szDesc = TranslateError(c,iError);
            error(szDesc);
        end
    catch
        rethrow(lasterror);
    end
    
    [dOutValues] = ReadGcsArray(c,sHeader, ppdData);
    
else
    error('%s not found',functionName);
end
