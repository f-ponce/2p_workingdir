function WriteConfigurationFromDatabaseToControllerAndSave ( c, szFilter, szConfigurationName )
%   DESCRIPTION
%   Loads the specified configuration (parameter set) from the PIStages3.db positioner database and writes it
%   to the nonvolatile memory of the controller.
%   The following actions are included:
%   - Configures the controller so that parameter setting is possible, e.g., sets the servo off
%   - Establishes the connection to the database
%   - Sets the parameters and checks for errors
%   Notes:
%   With GetAvailableControllerConfigurationsFromDatabase(), the configurations existing in PIStages3.db 
%   for the connected controller can be listed.
%
%   SYNTAX
%       PIdevice.WriteConfigurationFromDatabaseToControllerAndSave(szFilter, szConfigurationName)
% 
%   INPUT
%       szFilter (char array)                   string that assigns the configuration to an item of the controller. Consists of the key word
%                                               (e.g., „axis“) and ID of the item (e.g., “4”). Filter examples: "axis1", "axis4"
%
%       szConfigurationName (char array)        string with the name of a configuration existing in PIStages3.db (e.g., "V-551.4B")
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    bufferSize = 20000;
    szWarnings = blanks(20000);
    try
        [ bRet, ~, ~, warnings ] = calllib ( c.libalias, functionName, c.ID , szFilter, szConfigurationName, szWarnings, bufferSize );
        if ( 0 == bRet )
            iError = GetError ( c );
            szDesc = TranslateError ( c, iError );
            error ( szDesc );
        end
    
    catch ME
        completeString = sprintf('%s\n', ME.message);
        completeString = sprintf('%s%s', completeString, warnings);
        warning ( completeString );
    end
else
	error('%s not found',functionName);
end
