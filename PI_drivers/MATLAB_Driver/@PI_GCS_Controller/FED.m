function FED(c,szAxes,iInEdgeArray,iInParamArray)
%   DESCRIPTION
%   Moves given axis to a given signal edge and then moves out of any limit condition.
%
%   SYNTAX
%       PIdevice.FED(szAxes,iInEdgeArray,iInParamArray)
% 
%   INPUT
%       szAxes (char array)         axes to move
%
%       iInEdgeArray (int array)    Defines the type of edge the axis has to move to.
%                                   The following edge types are available:
%                                   1 = negative limit switch 
%                                   2 = positive limit switch 
%                                   3 = reference switch
%
%       iInParamArray (int array)   at present, this argument is not needed, should contain zeros
%  
%   PI MATLAB Class Library Version 1.5.0    
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
szAxes = ConvertCellArrayStringToString (szAxes);
if(any(strcmp(functionName,c.dllfunctions)))
	piInEdgeArray = libpointer('int32Ptr',iInEdgeArray);
	piInParamArray = libpointer('int32Ptr',iInParamArray);
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,szAxes,piInEdgeArray,piInParamArray);
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
