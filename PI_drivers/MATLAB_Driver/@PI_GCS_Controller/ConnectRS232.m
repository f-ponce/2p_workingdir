function c = ConnectRS232(c,iValues1,iValues2)
%   DESCRIPTION
%   Open an RS-232 ("COM") interface to a controller. The call also sets
%   the baud rate on the controller side. All future calls to control this
%   controller need the ID returned by this call
%
%   SYNTAX
%       [controllerID] = Controller.ConnectRS232(iValues1, iValues2)
%
%   INPUT
%       iValues1 (int)                                 Portnumber, COM port to use (e.g. 1 for "COM1")
%
%       iValues2 (int)                                 Baud rate to use
%
%   OUTPUT
%       [controllerID] (PI_GCS_Controller object)      ID of new object,throws error if interface could not
%                                                      be opened or no controller is responding, or controller
%                                                      responds that it is already connected via RS232.
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if(~libisloaded(c.libalias))
	c = LoadGCSDLL(c);
end
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[c.ID] = calllib(c.libalias,functionName,iValues1,iValues2);
		if (c.ID == -1)
			error ( 'Interface could not be opened or no controller is responding. Check if controller is switched on and properly connected.' );
        elseif (c.ID<-1)
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
