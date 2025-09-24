function [bRet] = HasPosChanged(c,szAxes,iValues)
%   DESCRIPTION
%   Queries whether the axis positions have changed since the last position query was sent. 
%
%   SYNTAX
%       PIdevice.HasPosChanged(c,szAxes,iValues)
% 
%   INPUT
%       szAxes (char array)             axis of controller
%
%       iValues (int)                   indicates whether axis positions have changed,
%                                       the response is bit-mapped
%
%   OUTPUT
%	[bRet]				indicates whether axis positions have changed, the response is bit-mapped 
%
%   PI MATLAB Class Library Version 1.5.0      
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
szAxes = ConvertCellArrayStringToString (szAxes);
AssertValueVectorSize( c, szAxes, iValues )
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piValues = libpointer('int32Ptr',iValues);
	try
		[bRet,szAxes,iValues] = calllib(c.libalias,functionName,c.ID,szAxes,piValues);
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
