function DPA(c,szPassword,szAxes,szParameter)
%   DESCRIPTION
%   Resets parameters or settings to default values. DPA does not overwrite parameters
%   or parameter-independent settings in non-volatile memory. 
%
%   SYNTAX
%       PIdevice.DPA(szPassword,szAxes,szParameter)
% 
%   INPUT
%       szPassword (char array)              The password depends on the parameter or parameter-independent
%                                            setting to be resetted. See the user manual of the controller for details.          
%
%       szAxes (char array)                  string with designators. For each designator in szAxes one parameter value is reset.
%
%       szParameter (char array)             string with parameter IDS
% 
%   PI MATLAB Class Library Version 1.5.0     
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
szAxes = ConvertCellArrayStringToString (szAxes);
if(any(strcmp(functionName,c.dllfunctions)))
    iParameter = str2num(szParameter);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,szPassword,szAxes,iParameter);
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
