function ReadConfigurationFromControllerToDatabase ( c, szFilter, szConfigurationName )
%   DESCRIPTION
%   Reads the configuration from the controllers’s volatile memory and writes it to the PIStages3.db positioner database.
%   Note:
%   It is strongly recommended to use ReadConfigurationFromControllerToDatabase() instead of 
%   AddStage() which has the same functionality. AddStage() is provided for compatibility reasons only.
%
%   SYNTAX
%       PIdevice.ReadConfigurationFromControllerToDatabase(szFilter, szConfigurationName)
% 
%   INPUT
%       szFilter (char array)                   string that defines the configuration to be read from the controller.
%                                               Consists of the key word (e.g., „axis“) and ID of the item (e.g., “4”).
%                                               Filter examples: "axis1", "axis4"
%
%       szConfigurationName (char array)        string that defines the name under which the configuration is to be 
%                                               saved in the PIStages3.db positioner database
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
    % Create variables for C interface
    bufferSize = 20000;
    szWarnings = blanks(20000);

    try
        % call C interface
        [ bRet, ~, ~, warnings ] = calllib ( c.libalias, functionName, c.ID, szFilter, szConfigurationName, szWarnings, bufferSize );
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
    