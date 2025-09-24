function [szAnswer] = qSIC ( c, iFastAlignmentInputIdsArray )
%   DESCRIPTION
%   Fast alignment: Gets the calculation settings for the given fast alignment input channel.
%   The calculation results can be queried with qTCI().
%   See the E712T0016 Technical Note (“Fast Alignment Routines”) for detailed descriptions of the fast 
%   alignment input channels.
% 
%   SYNTAX
%       [szAnswer] = PIdevice.qSIC(iFastAlignmentInputIdsArray)
% 
%   INPUT
%       iFastAlignmentInputIdsArray (int array)         The identifier of a fast alignment input channel of the controller.
%
%   OUTPUT
%       [szAnswer] (char array)                         buffer to receive the string read in from controller,
%                                                       lines are separated by '\n' ("line-feed").
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    piFastAlignmentInputIdsArray = libpointer('int32Ptr', iFastAlignmentInputIdsArray);
    iNumberOfInputIds = length ( iFastAlignmentInputIdsArray );
    szAnswer = blanks ( 2049 );
    try
        [ bRet, ~,szAnswer ] = calllib ( c.libalias, functionName, c.ID, piFastAlignmentInputIdsArray, iNumberOfInputIds, szAnswer, 2048);
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
