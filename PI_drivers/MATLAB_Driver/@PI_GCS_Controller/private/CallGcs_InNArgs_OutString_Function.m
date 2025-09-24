function [charBuffer] = CallGcs_InNArgs_OutString_Function(c,sGcsFunctionName,StartBufferSize,varargin)
% function [charBuffer] = CallGcs_InString_OutString_Function(c,sGcsFunctionName,StartBufferSize,sInString)
%PI MATLAB Class Library Version 1.2.0
% This code is provided by Physik Instrumente(PI) GmbH&Co.KG.
% You may alter it corresponding to your needs.
% Comments and Corrections are very welcome.
% Please contact us by mailing to support-software@pi.ws. Thank you.

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', sGcsFunctionName];
if(any(strcmp(functionName,c.dllfunctions)))
    bufferSize = StartBufferSize;
	charBuffer  = blanks(bufferSize+1);
    bufferOverflow = true;
    while (bufferOverflow)
        try
            switch nargin
                case 3 
                    [bRet,charBuffer] = calllib(c.libalias,functionName,c.ID,charBuffer,bufferSize);
                case 4 
                    [bRet,~,charBuffer] = calllib(c.libalias,functionName,c.ID,varargin{1},charBuffer,bufferSize);
                case 5 
                    [bRet,~,~,charBuffer] = calllib(c.libalias,functionName,c.ID,varargin{1},varargin{2},charBuffer,bufferSize);
                case 6 
                    [bRet,~,~,~,charBuffer] = calllib(c.libalias,functionName,c.ID,varargin{1},varargin{2},varargin{3},charBuffer,bufferSize);
                case 7 
                    [bRet,~,~,~,~,charBuffer] = calllib(c.libalias,functionName,c.ID,varargin{1},varargin{2},varargin{3},varargin{4},charBuffer,bufferSize);
                otherwise
                    error('Invalid number of Arguments!');
           end
            if(bRet==0)
                iError = GetError(c);
                if (iError == -5)
                    bufferSize     = bufferSize * 10;
                    charBuffer  = blanks(bufferSize+1);

                    if (bufferSize > 100000000)
                        error('The data to receive is larger than 100 MB.');
                    end

                else
                    szDesc = TranslateError(c,iError);
                    error(szDesc);
                end
            else
                if (CheckIfStringContainsSeparatorsAndReturnNumberOfLines(charBuffer) > 0)
                    charBuffer = regexp(charBuffer,'[\w-]+','match');
                end
                bufferOverflow = false;
            end
        catch
            rethrow(lasterror);
        end
    end
else
	error('%s not found',functionName);
end
