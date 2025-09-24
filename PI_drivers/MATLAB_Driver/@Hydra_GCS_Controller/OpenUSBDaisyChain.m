function [c, szDCDevices]  = OpenUSBDaisyChain(c,serialnumber)
if(~libisloaded(c.libalias))
    c = LoadGCSDLL(c);
end
%const char* sz, long* pNumber, char* szDeviceIDNs, long iBufferSize);
try
    iNumDevices = 0;
	piNumDevices = libpointer('int32Ptr',iNumDevices);
    szDCDevices = blanks(2001);
    [ c.DC_ID, sn, ndevs, szDCDevices]  = calllib(c.libalias,'PI_OpenUSBDaisyChain',serialnumber, piNumDevices,szDCDevices,2000);
    if (c.DC_ID<0)
        iError = GetError(c);
        szDesc = TranslateError(c,iError);
        error(szDesc);
    end
    s2 = regexp(szDCDevices, '\n', 'split');
    for lineindex = 1:size(s2,2)
        if(length(s2{lineindex}>1) && isempty(strfind(s2{lineindex},'not connected')))
            c.ConnectedDaisyChainDevices(lineindex).Name = s2{lineindex};
        end
    end
catch
    rethrow(lasterror);
end