function [value] = qSPV_Double(c,memType,containerUnit,functionUnit,parameter) 
%   DESCRIPTION
%   
%   Reads parameter values from the memory of the controller.
%    
%
%   SYNTAX
%        [value] = PIdevice.qSPV_Double(memType,containerUnit,functionUnit,parameter)
% 
%   INPUT
%       memType (char array)                 Type of memory from which values are to be read
%
%       containerUnit (char array)           Container unit whose parameters are to be queried
%
%       functionUnit (char array)            Function unit whose parameters are to be queried
%
%       parameter (char array)               The value of the parameter that is addressed is queried in the specified memory
%
%   OUTPUT
%       value (int array)                    Memory for the answer
%      
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end
memType = ConvertCellArrayStringToString (memType);
containerUnit = ConvertCellArrayStringToString (containerUnit);
functionUnit = ConvertCellArrayStringToString (functionUnit);
parameter = ConvertCellArrayStringToString (parameter);
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    value =  zeros(1,1);
    value = libpointer('doublePtr',value);
	try
		[bRet,~,~,~,~,value] = calllib(c.libalias,functionName,c.ID,memType,containerUnit,functionUnit,parameter,value);
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