function ATC(c,iValues1,iValues2)
%   DESCRIPTION
%   Automatic calibration. 
%   See "Calibration Settings" and the description of the ATC command in the User Manual of the controller 
%   for more information.
%
%   SYNTAX
%       ATC(iValues1, iValues2)
% 
%   INPUT
%       iValues1 (int)       string with channels of the piezo control electronics
%
%       iValues2 (int)       comprises the settings to be calibrated
%     
%   PI MATLAB Class Library Version 1.5.0 
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piValues1 = libpointer('int32Ptr',iValues1);
	piValues2 = libpointer('int32Ptr',iValues2);
	nValues = length(iValues1);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,piValues1,piValues2,nValues);
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
