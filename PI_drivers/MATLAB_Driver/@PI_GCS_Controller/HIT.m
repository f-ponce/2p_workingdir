function HIT(c,iTableId,iPointNumber,dValue)
%   DESCRIPTION
%   Fills the given lookup table with values.
%
%   SYNTAX
%       PIdevice.HIT(iTableId,iPointNumber,dValue)
% 
%   INPUT
%       iTableId (int array)            lookup tables of the controller
%
%       iPointNumber (int array)        points in the lookup table (index begins with 1)
%
%       dValue (double array)           values of the points (range is -1.0 to 1.0)
% 
%   PI MATLAB Class Library Version 1.5.0     
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    
    if((length(iTableId) ~= length(iPointNumber)) || (length(iTableId) ~= length(dValue))) 
        return;
    end
    
    len = length(iTableId);
	piTableId = libpointer('int32Ptr',iTableId);
	piPointNumber = libpointer('int32Ptr',iPointNumber);
	pdValue = libpointer('doublePtr',dValue);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,piTableId,piPointNumber,pdValue,len);
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
