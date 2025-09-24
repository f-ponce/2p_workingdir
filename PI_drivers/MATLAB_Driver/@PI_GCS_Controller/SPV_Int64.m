function SPV_Int64(c,memType,containerUnit,functionUnit,parameter,value)
%   DESCRIPTION
%   
%   Sets the value of a configuration parameter in a memory of the controller.   
%
%
%   SYNTAX
%        PIdevice.SPV_Int64(memType,containerUnit,functionUnit,parameter,value)
% 
%   INPUT
%       memType (char array)                     Type of memory in which the value is to be set
%
%       containerUnit (char array)               Container unit whose parameters are to be set
%
%       functionUnit (char array)                Function unit whose parameters are to be set
%
%       parameter (char array)                   The value of the parameter that is addressed is set in the specified memory.  
%
%       value (int array)                        The value of the parameter  
% 
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
memType = ConvertCellArrayStringToString (memType);
containerUnit = ConvertCellArrayStringToString (containerUnit);
functionUnit = ConvertCellArrayStringToString (functionUnit);
parameter = ConvertCellArrayStringToString (parameter);
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    try
        [bRet] = calllib(c.libalias,functionName,c.ID,memType,containerUnit,functionUnit,parameter,value);
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