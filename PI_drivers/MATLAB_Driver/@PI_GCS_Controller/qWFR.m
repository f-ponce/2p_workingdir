function [pbValueArray,szGcsArrayHeader] = qWFR (c,szAxis,iMode)
%   DESCRIPTION
%   
%   Get parameters of the last WFR command.
%
%
%   SYNTAX
%        [pbValueArray,szGcsArrayHeader] = PIdevice.qWFR (szAxis,iMode)
% 
%   INPUT
%       szAxis (char array)                            
%
%       iMode (int)                            
%
%   OUTPUT
%       [pbValueArray] (double array)                       
% 
%       [szGcsArrayHeader] (char array)                           
%      
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end
szAxis = ConvertCellArrayStringToString (szAxis);
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    szGcsArrayHeader =  blanks(10001);
    
	pbValueArray = libpointer('doublePtr');
	try
		[bRet,~,pbValueArray,szGcsArrayHeader] = calllib(c.libalias,functionName,c.ID,szAxis,iMode,pbValueArray,szGcsArrayHeader,10000);
		if(bRet==0)
			iError = GetError(c);
			szDesc = TranslateError(c,iError);
			error(szDesc);
		end
	catch
		rethrow(lasterror);
    end
    
    [pbValueArray] = ReadGCS30Array(c,szGcsArrayHeader, pbValueArray);
else
	error('%s not found',functionName);
end

