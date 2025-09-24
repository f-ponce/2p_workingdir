function GOH(c,szAxes)
%   DESCRIPTION
%   Move all axes in szAxes to their home positions (is equivalent 
%   to moving the axes to positions 0 using MOV()).
%   Depending on the controller, the definition of the home position
%   can be changed with DFH(). 
%
%   SYNTAX
%       PIdevice.GOH(szAxes)
% 
%   INPUT
%       szAxes (char array)         string with axes, if '' all axes are affected
% 
%   PI MATLAB Class Library Version 1.5.0     
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
szAxes = ConvertCellArrayStringToString (szAxes);
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,szAxes);
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
