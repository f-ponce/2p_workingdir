function [c] = ConnectTCPIPByDescription(c,szIdentifier)
%   DESCRIPTION
%   Open a TCP/IP connection to the controller using one of the identification
%   strings listed by EnumerateTCPIPDevices(). All future calls to control 
%   this controller need the ID returned by this call. Will fail if there is 
%   already a connection. Communication  cannot  be  maintained  after  the
%   controller is power-cycled or rebooted. The connection must then be closed and reopened. 
%
%   SYNTAX
%       [controllerID] = Controller.ConnectTCPIPByDescription(szIdentifier)
%
%   INPUT
%       szIdentifier (char array)                      the description of the controller returned by 
%                                                      EnumerateTCPIPDevices()
%
%   OUTPUT
%       [controllerID] (PI_GCS_Controller object)      ID of new object,throws error if interface could not
%                                                      be opened or no controller is responding, or controller
%                                                      responds that it is already connected via TCP/IP.
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	if(nargin<2),    szIdentifier = '';end,
	try
		[c.ID] = calllib(c.libalias,functionName,szIdentifier);
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
