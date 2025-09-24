function [c] = InterfaceSetupDlg(c,szIdentifier)
%   DESCRIPTION
%   Open  dialog  to  let  user  select  the  interface  and  create  a  new  PI  object.
%   All  future  calls  to  control  this controller need the ID returned by this call. 
%   See Interface Settings (p. 18) for a detailed description of the dialogs shown.      
%
%   SYNTAX
%       PIdevice = Controller.InterfaceSetupDlg()
%
%   OUTPUT
%       [PIDevice] (PI_GCS_Controller)         ID of new object,throws error if interface could not
%                                              be opened or no controller is responding 
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	if(nargin<2),    szIdentifier = '';end,
	try
		[c.ID, szIdentifier] = calllib(c.libalias,functionName,szIdentifier);
		if(c.ID<0)
			iError = GetError(c);
			szDesc = TranslateError(c,iError);
			error(szDesc);
            
            c.Destroy;
            clear c;
		end
	catch
		rethrow(lasterror);
	end
else
	error('%s not found',functionName);
end
