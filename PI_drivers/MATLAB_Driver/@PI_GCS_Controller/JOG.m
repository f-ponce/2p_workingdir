function JOG ( c, szAxes, valueArray )
%   DESCRIPTION
%   Starts motion with given velocities for szAxes. Motion will not start if the piezo channel belonging 
%   to the axis is in OFFLINE mode. When motion started with JOG() is executed, the target value is changed 
%   continuously according to the given velocity (can be checked with qMOV()). 
%   Motion started with JOG() is executed in addition to motion started with other move commands 
%   (e.g. MOV() or MVR()).
%
%   SYNTAX
%       PIdevice.JOG(szAxes, valueArray)
%
%   INPUT
%       szAxes (char array)         string with axes
%       valueArray (double array)   velocities of the axes (used only for motion caused by JOG()
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
szAxes = ConvertCellArrayStringToString (szAxes);
if(any(strcmp(functionName,c.dllfunctions)))
    pdValueArray = libpointer('doublePtr', valueArray);
	try
        [ bRet ] = calllib ( c.libalias, functionName, c.ID, szAxes, pdValueArray );
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
