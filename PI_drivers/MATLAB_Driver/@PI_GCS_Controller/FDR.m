function FDR ( c, szScanRoutineName, szScanAxis, dScanAxisRange, szStepAxis, dStepAxisRange, szParameters )
%   DESCRIPTION
%   Fast alignment: Defines a fast alignment area scan routine. Use FRS() to start the routine. With 
%   qFRR(), you can read out the definition and the results of the routine.
%   See the E712T0016 Technical Note (“Fast Alignment Routines”) for detailed descriptions.
%
%   SYNTAX
%       PIdevice.FDR(szScanRoutineName, szScanAxis, dScanAxisRange, szStepAxis, dStepAxisRange, szParameters )
% 
%   INPUT
%       szScanRoutineName (char)            The identifier of the routine
%
%       szScanAxis (char)                   Identifier of the axis that is to be the master axis of the scan routine
%
%       dScanAxisRange (double)             Scan range for the scan axis
%
%       szStepAxis (char)                   Identifier of the step axis
%
%       dStepAxisRange (double)             Scan range for the step axis
%
%       szParameters (char array)           The parameters are optional. For parameters that are omitted, default values will be used.
%                                           [L <threshold level>] // float
%                                              L: Required keyword
%                                              Minimum intensity threshold of the analog input signal. If during an area scan routine no value 
%                                              of the analog input signal is higher than the given minimum threshold level, PI_qFRR() will 
%                                              report “not successful” for the routine.
%                                           [A <alignment signal input channel>] // int
%                                              A: Required keyword
%                                              <alignment signal input channel>: Identifier of the fast alignment input channel whose maximum 
%                                              intensity is sought.
%                                           [F <frequency>] // float
%                                              F: Required keyword
%                                              Frequency of the scan axis.
%                                           [V <velocity>] // float
%                                              V: Required keyword
%                                              <velocity>: Velocity of the step axis.
%                                           [MP1 <scan axis middle position>] // float
%                                              MP1: Required keyword
%                                              <scan axis middle position>: Middle position of the scan range for the scan axis.
%                                           [MP2 <step axis middle position>] // float
%                                              MP2: Required keyword
%                                              <step axis middle position>: Middle position of the scan range for the step axis.
%                                           [TT <target type>] // int
%                                              TT: Required keyword
%                                              <target type>: ID of the area scan type. Possible values:
%                                              0 = raster scan
%                                              1 = spiral scan
%                                           [CM <estimation method>] // int
%                                              CM: Required keyword
%                                              <estimation method>: ID of the estimation method for the position of the global intensity 
%                                              maximum:
%                                              0 = global maximum is at the position where the maximum value was recorded
%                                              1 = position of global maximum is calculated from the recorded data using a Gaussian LS fit.
%                                              2 = position of global maximum is calculated from the recorded data using an analogy to a 
%                                              center-of-gravity calculation
%                                           [MIIL <minimum level of fast alignment input>] // float
%                                              MIIL: Required keyword
%                                              <minimum level of fast alignment input>: Minimum intensity to be used for estimation method 1 
%                                              or 2 (see CM above), in % of the maximum intensity that has been recorded.
%                                           [MAIL <maximum level of fast alignment input>] // float
%                                              MAIL: Required keyword
%                                              <maximum level of fast alignment input>: Maximum intensity to be used for estimation method 1 
%                                              or 2 (see CM above), in % of the maximum intensity that has been recorded.
%                                           [SP <stop position option>] // int
%                                              SP: Required keyword
%                                              <stop position option>: ID of the position to be approached by scan axis and step axis when the 
%                                              area scan routine has been completed:
%                                              0 = move to scan axis and step axis position with the maximum intensity of the analog input 
%                                              signal
%                                              1 = stay at the end position of the area scan routine
%                                              2 = move to the start position of the area scan routine
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
        [bRet] = calllib ( c.libalias, functionName, c.ID, szScanRoutineName, szScanAxis, dScanAxisRange, szStepAxis, dStepAxisRange, szParameters );
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
