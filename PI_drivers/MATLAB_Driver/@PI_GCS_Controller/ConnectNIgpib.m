function c = ConnectNIgpib(c,iValues1,iValues2)
%   DESCRIPTION
%   Open a connection from a National Instruments IEEE 488 board to the controller. 
%   All future calls to control this controller need the ID returned by this call.
%
%
%   SYNTAX
%       [controllerID] = Controller.ConnectNIgpib(iValues1, iValues2)
% 
%   INPUT
%       iValues1 (int)                                 number of board (check NI installation software)
%
%       iValues2 (int)                                 address of connected device
%
%   OUTPUT
%       [controllerID] (PI_GCS_Controller object)      ID of new object,throws error if interface could not
%                                                      be opened or no controller is responding.
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% only load dll if it wasn't loaded before
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
