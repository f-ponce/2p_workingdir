function [dOutValues,szHeader] = qJLT(c,iJoystickIDs,iJoystickAxisIDs,iOffset,iNumberOfValues)
%   DESCRIPTION
%   Get joystick lookup table values.
%
%   SYNTAX
%       [dOutValues,szHeader] = PIdevice.qJLT(iJoystickIDs,iJoystickAxisIDs,iOffset,iNumberOfValues)
% 
%   INPUT
%       iJoystickIDs (int array)            array with joystick devices connected to the controller
%
%       iJoystickAxisIDs (int array)        array with joystick axes
%
%       iOffset (int)                       index of first point to be read (starts with index 1)
%
%       iNumberOfValues (int)               number of points to read
%
%   OUTPUT
%       [dOutValues] (double array)         array to store the data; data from all tables read will be 
%                                           placed in the same array with the values interspersed;
%                                           the DLL will allocate enough memory to store all data,
%                                           call GetAsyncBufferIndex() to find out how many data points have 
%                                           
%       [szHeader] (char array)             buffer to store the GCS array header
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	piJoystickIDs = libpointer('int32Ptr',iJoystickIDs);
	piJoystickAxisIDs = libpointer('int32Ptr',iJoystickAxisIDs);
	szHeader = blanks(1000);
	ppdData = libpointer('doublePtr');
	nTables = length(iJoystickIDs);
    dOutValues = 0;
    try
		[bRet,~,~,ppdData,szHeader] = calllib(c.libalias,functionName,c.ID,piJoystickIDs,piJoystickAxisIDs,nTables,iOffset,iNumberOfValues,ppdData,szHeader,999);
        if(bRet==0)
            iError = GetError(c);
            szDesc = TranslateError(c,iError);
            error(szDesc);
        end
	catch
		rethrow(lasterror);
    end
        
    [dOutValues] = ReadGcsArray(c,sHeader, ppdData);
else
	error('%s not found',functionName);
end
