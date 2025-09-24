function [dCalculatedInputValueArray] = qTCI ( c, iFastAlignmentInputIdsArray )
%   DESCRIPTION
%   Fast alignment: Gets calculated value of given fast alignment input channel.
%   The calculation settings of a fast alignment input channel can be defined with SIC() and queried with qSIC().
%   See the E712T0016 Technical Note (“Fast Alignment Routines”) for detailed descriptions of the fast 
%   alignment input channels.
%
%   SYNTAX
%       [dCalculatedInputValueArray] = PIdevice.qTCI(iFastAlignmentInputIdsArray)
% 
%   INPUT
%       iFastAlignmentInputIdsArray (int array)         The identifier of a fast alignment input channel of the controller.
%
%   OUTPUT
%       [dCalculatedInputValueArray] (double array)     The current value of the calculated input.
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    piFastAlignmentInputIdsArray  = libpointer ( 'int32Ptr', iFastAlignmentInputIdsArray );
    iArraySize = length ( iFastAlignmentInputIdsArray );
    dCalculatedInputValueArray = zeros ( iArraySize, 1 );
    pdCalculatedInputValueArray = libpointer('doublePtr', dCalculatedInputValueArray);
	try
        [ bRet, ~, dCalculatedInputValueArray ] = calllib ( c.libalias, functionName, c.ID, piFastAlignmentInputIdsArray, pdCalculatedInputValueArray, iArraySize );
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
