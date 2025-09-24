function setPMTs(state, verbose)
% Set PMT power levels through NI-USB6001
%
% Input
%   - state: 2x1 array of voltage values, range: 0-5V.
%            OR blank both PMTs with single value of 0
%
% Example:
%   - setPMTs([2,5])    sets PMT0 to 2V and PMT1 to 5V
%   - setPMTs(0)        blanks both PMTs


if nargin < 2
    verbose = 0;
end

% Only connect to the board the first time the function is called.
global USB6001

if isempty(USB6001)
    if verbose, display('Connecting to USB6001'); end
    USB6001=connectToUSB6001;
end


% Pull in global state variable
global pmtState

if nargin > 0
    if state == 0
        state = [0 0];  %convert abbreviated value to blank PMTs
    end
    pmtState = state;
end

pmtState(pmtState>5) = 0;
pmtState(pmtState<0) = 0;

outputSingleScan(USB6001,pmtState);
