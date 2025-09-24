function c = PI_GCS_Controller()
%   DESCRIPTION
%   Loads the PI_GCS_Controller
%
%   SYNTAX
%       [Controller] = PI_GCS_Controller()
%
%   OUTPUT
%       [Controller] (PI_GCS_Controller object)         new PI_GCS_Controller object
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin==0
	c.DLLNameStub = 'PI_GCS2_DLL';
	c.libalias = 'PI';
    
    dirOfPI_GCS_ControllerFile = mfilename ('fullpath');
    matlabDriverPathTokenizer = regexp (dirOfPI_GCS_ControllerFile, '\@PI_GCS_Controller', 'split');
    c.DriverDirectoryOnWindows = char (matlabDriverPathTokenizer(1));
    
	c = SetDefaults(c);
	c = LoadGCSDLL(c);
	c = class(c,'PI_GCS_Controller');
end
