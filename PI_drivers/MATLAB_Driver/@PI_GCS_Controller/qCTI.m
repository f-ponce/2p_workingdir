function szValueArray = qCTI ( c, iTriggerInputIds, iTriggerParameters )
%   DESCRIPTION
%   Get the trigger input configuration for the given trigger input line.
%
%   SYNTAX
%       szValueArray = PIdevice.qCTI(iTriggerInputIds, iTriggerParameters)
% 
%   INPUT
%       iTriggerInputIds (int array)        is an array with the trigger input lines of the controller
%
%       iTriggerParameters (int array)      is an array with the CTI parameter IDs
%
%   OUTPUT
%       szValueArray (char array)           buffer to receive the values to which the CTI parameters are set, each line has a value 
%                                           of a single CTI parameter, lines are separated by '\n' ("line-feed")
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functionName = ['PI_', mfilename];

% Method available?
if ( ~any ( strcmp ( functionName, c.dllfunctions ) ) ), error('Method %s not found',functionName), end;


% Create variables for C interface
piTriggerInputIds = libpointer('int32Ptr', iTriggerInputIds);
piTriggerParameters = libpointer('int32Ptr', iTriggerParameters);
iArraySize = length ( iTriggerInputIds );
szValueArray = blanks ( 10001 );


try
    % call C interface
    [ bRet, ~, ~, szValueArray ] = calllib ( c.libalias, functionName, c.ID, ...
        piTriggerInputIds, piTriggerParameters, szValueArray, iArraySize, 10000 );
    
    if ( 0 == bRet )
        iError = GetError ( c );
        szDesc = TranslateError ( c, iError );
        error ( szDesc );
    end
    
catch ME
    error ( ME.message );
end