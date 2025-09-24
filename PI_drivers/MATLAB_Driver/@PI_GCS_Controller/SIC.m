function SIC ( c, iFastAlignmentInputId, iCalcType, dParameters )
%   DESCRIPTION
%   Fast alignment: Defines calculation settings for the given fast alignment input channel.
%   The current valid calculation settings can be queried with qSIC(). The calculation results can be 
%   queried with qTCI().
%   See the E712T0016 Technical Note (“Fast Alignment Routines”) for detailed descriptions.
%
%   SYNTAX
%       PIdevice.SIC(iFastAlignmentInputId, iCalcType, dParameters)
% 
%   INPUT
%       iFastAlignmentInputId (int)             The identifier of a fast alignment input channel of the controller.
%
%       iCalcType (int)                         The type of calculation to be applied, can be:
%                                                 0 = No calculation
%                                                 1 = Exponential calculation
%                                                 2 = Polynomial calculation
%
%       dParameters (double array)              The settings for the selected calculation type.
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    pdParameters = libpointer('doublePtr', dParameters);
    iNumberOfParameters = length ( dParameters );
    try
        [ bRet ] = calllib ( c.libalias, functionName, c.ID, iFastAlignmentInputId, iCalcType, pdParameters, iNumberOfParameters );
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
