function FGC ( c, szProcessIds, dScanAxisCenterValueArray, dStepAxisCenterValueArray )
%   DESCRIPTION
%   Fast alignment: Change center position of gradient search routine.
%
%   SYNTAX
%       PIdecive.FGC(szProcessIds, dScanAxisCenterValueArray, dStepAxisCenterValueArray)
% 
%   INPUT
%       szProcessIds (char)                         The identifier of the routine
%
%       dScanAxisCenterValueArray (double array)    Center position of the circular motion for the scan axis.
%
%       dStepAxisCenterValueArray (double array)    Center position of the circular motion for the step axis.
%   
%   PI MATLAB Class Library Version 1.5.0   
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    pdScanAxisCenterValueArray = libpointer('doublePtr', dScanAxisCenterValueArray);
    pdStepAxisCenterValueArray = libpointer('doublePtr', dStepAxisCenterValueArray);
	try
        [bRet] = calllib ( c.libalias, functionName, c.ID, szProcessIds, pdScanAxisCenterValueArray, pdStepAxisCenterValueArray );
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
