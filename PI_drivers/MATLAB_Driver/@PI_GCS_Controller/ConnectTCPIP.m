function c = ConnectTCPIP(c, szHostName, nPort)
%   DESCRIPTION
%   Open a TCP/IP connection to the controller. All future calls to control 
%   this controller need the ID returned by this call. Will fail if there is 
%   already a connection. Communication  cannot  be  maintained  after  the
%   controller is  power-cycled  or  rebooted.  The  connection must then 
%   be closed and reopened.
%
%   SYNTAX
%       [controllerID] = Controller.ConnectTCPIP(szHostName, nPort)
%
%   INPUT
%       szHostName (char array)                        hoste name of the controller, can be the IP adress
%                                                      e.g."192.168.1.1"(leading zeros may cause problems)
%
%       nPort (int)                                    port to connect to. For controllers from PI,
%                                                      the port is always 50000.
%
%   OUTPUT
%       [controllerID] (PI_GCS_Controller object)      ID of new object,throws error if interface could not
%                                                      be opened or no controller is responding, or controller
%                                                      responds that it is already connected via TCP/IP.
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
