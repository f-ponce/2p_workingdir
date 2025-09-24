function PGS(c,piPIEZOWALKChannelsArray)
%   DESCRIPTION
%   
%    Piezo Gain correction parameter Save.
%    Makes the current settings of the parameters for the Nexline channel piezo gain correction to default   
%    
%
%   SYNTAX
%        PIdevice.PGS(piPIEZOWALKChannelsArray)
% 
%   INPUT
%       piPIEZOWALKChannelsArray (int array)                one Nexline channel
%
%   
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    piPIEZOWALKChannelsArray = libpointer('int32Ptr',piPIEZOWALKChannelsArray);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,piPIEZOWALKChannelsArray,length(piPIEZOWALKChannelsArray));
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