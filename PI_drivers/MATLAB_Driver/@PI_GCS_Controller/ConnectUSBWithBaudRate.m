function c = ConnectUSBWithBaudRate(c,szHostName,nPort)
%   DESCRIPTION
%   Open an USB connection to a controller using one of the identification 
%   strings listed by EnumerateUSB(). By specifying the baud rate, a 
%   connection using a different baudrate than the standard will be 
%   established more quickly. All future calls to control this controller 
%   need the ID returned by this call. Will fail if there is already a 
%   connection.
%   Communication cannot be maintained after the controller is power-cycled
%   or rebooted. The connection  must then be closed and reopened. 
%
%   SYNTAX
%       [controllerID] = Controller.USBWithBaudRate(szHostName, nPort)
%
%   INPUT
%       szHostName (char array)                        the description of the controller returned by 
%                                                      EnumerateUSB()
%
%       nPort (int)                                    Baudrate to use
%
%   OUTPUT
%       [controllerID] (PI_GCS_Controller object)      ID of new object,throws error if interface could not
%                                                      be opened or no controller is responding, or the
%                                                      controller responds that it is already connected via USB
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 

% only load dll if it wasn't loaded before
if(~libisloaded(c.libalias))
	c = LoadGCSDLL(c);
end
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[c.ID] = calllib(c.libalias,functionName,szHostName,nPort);
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
