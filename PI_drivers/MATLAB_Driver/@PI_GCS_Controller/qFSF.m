function [ dForceValue1Array, dPositionOffsetArray, dForceValue2Array ] = qFSF ( c, szAxis )
%   DESCRIPTION
%   Gets the settings made with FSF() for the find-surface procedure.
%
%   SYNTAX
%       [dForceValue1Array, dPositionOffsetArray, dForceValue2Array] = PIdevice.qFSF(szAxis)
% 
%   INPUT
%       szAxis (char array)                     string with axes
%
%   OUTPUT
%       [dForceValue1Array] (double array)      array to receive the configured forceValue1 of the specified axes
%
%       [dPositionOffsetArray] (double array)   array to receive the configured position offset of the specified axes
%
%       [dForceValue2Array] (double array)      array to receive the configured forceValue2 of the specified axes
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    dForceValue1Array = 0;
    pForceValue1Array = libpointer ( 'doublePtr', dForceValue1Array );
    dPositionOffsetArray = 0;
    pPositionOffsetArray = libpointer ( 'doublePtr', dPositionOffsetArray );
    dForceValue2Array = 0;
    pForceValue2Array = libpointer ( 'doublePtr', dForceValue2Array );
	try
        [ bRet, ~, dForceValue1Array, dPositionOffsetArray, dForceValue2Array ] = calllib ( c.libalias, functionName, c.ID, szAxis, pForceValue1Array, pPositionOffsetArray, pForceValue2Array );
		if(bRet==0)
			iError = GetError(c);
			szDesc = TranslateError(c,iError);
			error(szDesc);
		end
	catch
		rethrow(lasterror)
	end
else
	error('%s not found',functionName);
end
