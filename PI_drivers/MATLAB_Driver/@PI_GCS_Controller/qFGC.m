function [ dScanAxisCenterValueArray, dStepAxisCenterValueArray ]  = qFGC ( c, szProcessIds )
%   DESCRIPTION
%   Fast alignment: Gets the current center position of the circular motion of a gradient search routine.
%
%   SYNTAX
%       [dScanAxisCenterValueArray, dStepAxisCenterValueArray]  = PIdevice.qFGC(szProcessIds)
% 
%   INPUT
%       szProcessIds (char array)                       the identifier of the routine
%
%   OUTPUT
%       [dScanAxisCenterValueArray] (double)            Current center position of the circular motion for the scan axis
%
%       [dStepAxisCenterValueArray] (double)            Current center position of the circular motion for the step axis      
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];

len = GetNrAxesInString ( c, szProcessIds );
if(len == 0)
    return;
end

if(any(strcmp(functionName,c.dllfunctions)))
    dScanAxisCenterValueArray = zeros ( len, 1 );
    dStepAxisCenterValueArray = zeros ( len, 1 );
    pdScanAxisCenterValueArray = libpointer ( 'doublePtr', dScanAxisCenterValueArray );
    pdStepAxisCenterValueArray = libpointer ( 'doublePtr', dStepAxisCenterValueArray );
	try
        [ bRet, ~, dScanAxisCenterValueArray, dStepAxisCenterValueArray ] = calllib ( c.libalias, functionName, c.ID, szProcessIds, pdScanAxisCenterValueArray, pdStepAxisCenterValueArray );
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
