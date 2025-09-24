function FDG ( c, szScanRoutineName, szScanAxis, szStepAxis, szParameters )
%   DESCRIPTION
%   Fast alignment: Defines a fast alignment gradient search routine. Use FRS() to start the routine. 
%   With qFRR(), you can read out the definition and the results of the routine.
%   See the E712T0016 Technical Note (“Fast Alignment Routines”) for detailed descriptions.
%
%   SYNTAX
%       PIdevice.FDG (szScanRoutineName, szScanAxis, szStepAxis, szParameters )
% 
%   INPUT
%       szScanRoutineName (char)        The identifier of the routine
%
%       szScanAxis (char)               Identifier of the axis that is to be the master axis of the gradient search routine.    
%
%       szStepAxis (char)               Identifier of the axis that is to be the second axis of the gradient search routine.
%
%       szParameters (char array)       The parameters are optional. For parameters that are omitted, default values will be used.
%                                       [ML <stop level>] // float
%                                           ML: Required keyword
%                                           <stop level>: Gives one stop criterion for the gradient search routine.
%                                       [A <alignment signal input channel>] // int
%                                           A: Required keyword
%                                           <alignment signal input channel>: Identifier of the fast alignment input channel whose maximum 
%                                           intensity is sought.
%                                       [MIA <min radius>] // float
%                                           MIA: Required keyword
%                                           <min radius>: Minimum radius of the circular motion for scan axis and step axis (= amplitude of 
%                                           the sine curve).
%                                       [MAA <max radius>] // float
%                                           MAA: Required keyword
%                                           <max radius>: Maximum radius of the circular motion for scan axis and step axis (= amplitude of 
%                                           the sine curve).
%                                       [F <frequency>] // float
%                                           F: Required keyword
%                                           <frequency>: Frequency of the sine curves for scan axis and step axis. 
%                                       [SP <speed factor>] // float
%                                           SP: Required keyword
%                                           <speed factor>: The speed factor can be used to speed up the offset change.
%                                       [V <max velocity>]  // float
%                                           V: Required keyword
%                                           <max velocity>: Velocity limit for the offset change..
%                                       [MDC <max direction changes>] // int
%                                           MDC: Required keyword
%                                           <max direction changes>: Gives one stop criterion for the gradient search routine.
%                                       [SPO <speed offset>] // float
%                                           SPO: Required keyword
%                                           <speed offset>: Offset that can be applied in the velocity calculation.
%                                       [V <max velocity>]  // float
%                                           V: Required keyword
%                                           <max velocity>: Velocity limit for the offset change..
%                                       [MDC <max direction changes>] // int
%                                           MDC: Required keyword
%                                           <max direction changes>: Gives one stop criterion for the gradient search routine.
%                                       [SPO <speed offset>] // float
%                                           SPO: Required keyword
%                                           <speed offset>: Offset that can be applied in the velocity calculation.
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
        [bRet] = calllib ( c.libalias, functionName, c.ID, szScanRoutineName, szScanAxis, szStepAxis, szParameters );
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
