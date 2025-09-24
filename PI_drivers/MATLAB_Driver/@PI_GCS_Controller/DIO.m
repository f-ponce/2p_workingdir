function DIO(c,ChannelsArray,iValues)
%   DESCRIPTION
%   Set digital output channels HIGH or LOW.
%
%   SYNTAX
%       PIdevice.DIO(ChannelsArray,iValues)
% 
%   INPUT
%       ChannelsArray (int array)       array containing digital output channel identifiers
%
%       iValues (int array)             array containing the states of specified digital ouput channels, 
%                                       1 if HIGH, 0 if LOW
%                                       If piChannelsArray contains 0, the array is a bit pattern which 
%                                       gives the states of all lines
%
%   PI MATLAB Class Library Version 1.5.0      
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piChannelsArray = libpointer('int32Ptr',ChannelsArray);
	piValues = libpointer('int32Ptr',iValues);
	nValues = length(ChannelsArray);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,piChannelsArray,piValues,nValues);
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
