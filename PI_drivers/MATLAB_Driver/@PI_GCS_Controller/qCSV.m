function [dOutValues1] = qCSV(c)
%   DESCRIPTION
%   Returns the current CommandSyntaxVersion.
%
%   SYNTAX
%       [dOutValues1] = PIdevice.qCSV()
%
%   OUTPUT
%       [dOutValues1] (double)          variable to receive the current command syntax version (2.0 for GCS 2.0).
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	dOutValues1 = zeros(1,1);
	pdOutValues1 = libpointer('doublePtr',dOutValues1);
	try
		[bRet,dOutValues1] = calllib(c.libalias,functionName,c.ID,pdOutValues1);
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
