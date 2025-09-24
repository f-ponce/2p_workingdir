function [szConfigurations] = GetAvailableControllerConfigurationsFromDatabase ( c )
%   DESCRIPTION
%   Gets the available configurations for the connected controller from the PIStages3.db positioner database.
%   The configurations listed with PI_GetAvailableControllerConfigurationsFromDatabase() can be assigned to 
%   the items of the controller with PI_WriteConfigurationFromDatabaseToController().
%   Note:
%   It is strongly recommended to use GetAvailableControllerConfigurationsFromDatabase() instead of 
%   qVST() which has the same functionality. qVST() is provided for compatibility reasons only.
%
%   SYNTAX
%       PIdevice.GetAvailableControllerConfigurationsFromDatabase
% 
%   OUTPUT
%       [szConfigurations] (char array)             string that contains the names of the configurations that 
%                                                   are saved in the PIStages3.db positioner database for the
%                                                   connected controller
%  
%   PI MATLAB Class Library Version 1.5.0  
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    bufferSize = 20000;
    szConfigurations = blanks(20000);
    try
        [ bRet, szConfigurations ] = calllib ( c.libalias, functionName, c.ID , szConfigurations, bufferSize );
        if ( 0 == bRet )
            iError = GetError ( c );
            szDesc = TranslateError ( c, iError );
            error ( szDesc );
        end
    
    catch ME
        error (ME.message);
    end
else
	error('%s not found',functionName);
end
