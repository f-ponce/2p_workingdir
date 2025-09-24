function [szConfigurations] = GetAvailableControllerConfigurationsFromDatabaseByType ( c, ConfigurationsType )
%   DESCRIPTION
%   Gets the available configurations for the connected controller from the PIStages3.db positioner database.
%   The configurations listed with GetAvailableControllerConfigurationsFromDatabaseByType() can be 
%   assigned to the items of the controller with PI_WriteConfigurationFromDatabaseToController().
%   Similar to PI_GetAvailableControllerConfigurationsFromDatabase() but in addition, the returned 
%   configurations can be limited to certain types. Available types are:
%   PI_CONFIGURATION_TYPE_ALL - all configurations 
%   PI_CONFIGURATION_TYPE_USER – all user configurations 
%   PI_CONFIGURATION_TYPE_STANDARD – all standard configurations
%   PI_CONFIGURATION_TYPE_CUSTOM – all custom configurations
%   The different types can be combined, e.g.,
%   “PI_CONFIGURATION_TYPE_USER | PI_CONFIGURATION_TYPE_STANDARD” 
%   will match all user and all standard configurations, but not any custom configuration.
%
%   SYNTAX
%       PIdevice.GetAvailableControllerConfigurationsFromDatabaseByType(ConfigurationsType)
% 
%   INPUT
%       ConfigurationsType (int)            type pf configurations to be returned (see details above)
%
%   OUTPUT
%       [szConfigurations] (char array)     string that contains the names of the configurations that are saved in the 
%                                           PIStages3.db positioner database for the connected controller
%  
%   PI MATLAB Class Library Version 1.5.0    
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    bufferSize = 20000;
    szConfigurations = blanks(20000);
    try
        [ bRet, szConfigurations ] = calllib ( c.libalias, functionName, c.ID , szConfigurations, bufferSize, ConfigurationsType );
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
