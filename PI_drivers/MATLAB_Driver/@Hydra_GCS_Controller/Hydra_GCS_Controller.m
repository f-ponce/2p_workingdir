function c = Hydra_GCS_Controller()
% Hydra_GCS_Controller controller class constructor
%PI MATLAB Class Library Version 1.1.1
% This code is provided by Physik Instrumente(PI) GmbH&Co.KG.
% You may alter it corresponding to your needs.
% Comments and Corrections are very welcome.
% Please contact us by mailing to c.wurm@pi.ws. Thank you.


if nargin==0
	c.DLLNameStub = 'PI_HydraPollux_GCS2_DLL';
	c.libalias = 'HydraPollux';
	c.ControllerName = [];
	c.DLLName = [];
	c = SetDefaults(c);
	% only load dll if it wasn't loaded before
	if(~libisloaded(c.libalias))
		c = LoadGCSDLL(c);
	end
	if(~libisloaded(c.libalias))
		error('DLL could not be loaded');
	end
	c = class(c,'Hydra_GCS_Controller');
end
