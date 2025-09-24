function [versionNumber] = GetVersionNumber(c)
%function [versionNumber] = GetVersionNumber(c)
%PI MATLAB Class Library Version 1.2.0
% This code is provided by Physik Instrumente(PI) GmbH&Co.KG.
% You may alter it corresponding to your needs.
% Comments and Corrections are very welcome.
% Please contact us by mailing to support-software@pi.ws. Thank you.

fileIdRead  = fopen ( [c.DriverDirectoryOnWindows, '\', 'Version.txt'],  'r' );
currentLine = fgets(fileIdRead);
versionNumber = '';

while ( currentLine > 0)
    if ( ~isempty ( regexp ( currentLine, 'Version:\s*', 'match' ) ) )
        versionNumber = regexp ( currentLine, 'Version:\s*', 'split' );
        versionNumber = versionNumber{end};
        break;
    end    
    
    currentLine = fgets(fileIdRead);
end

versionNumber = ['PI MATLAB Driver Version Number: ', versionNumber]; 