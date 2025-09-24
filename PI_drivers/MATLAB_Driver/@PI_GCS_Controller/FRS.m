function FRS ( c, szScanRoutineNames )
%   DESCRIPTION
%   Fast alignment: Starts a fast alignment routine. The routine must have been defined before with FDR() 
%   or FDG() or via the appropriate parameters (see E712T0016 Technical Note).
%
%   SYNTAX
%       PIdevice.FRS(szScanRoutineNames)
% 
%   INPUT
%       szScanRoutineNames (char array)         The identifier of the routine. Multiple gradient search routines can run 
%                                               synchronously for the axes on both the sender and receiver side. 
%                                               They can be coupled to each other with FRC().
% 
%   PI MATLAB Class Library Version 1.5.0     
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
        [ bRet ] = calllib ( c.libalias, functionName, c.ID, szScanRoutineNames );
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
