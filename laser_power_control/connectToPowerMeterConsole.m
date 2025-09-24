function connectToPowerMeterConsole(verbose)
% Connect to Thorlabs PM100D over VISA-USB and leave global 'PM100D'.
% Uses your resource: USB0::0x1313::0x8070::P0000791::0::INSTR
% Works with NI-VISA or Keysight VISA. Keeps old fprintf/fscanf style.
%
% Usage:
%   connectToPowerMeterConsole;        % quiet
%   connectToPowerMeterConsole(1);     % verbose
%
% After connecting:
%   global PM100D
%   fprintf(PM100D,"CONF:POW\n");
%   fprintf(PM100D,"SENS:CORR:WAV %d\n", 930);
%   fprintf(PM100D,"READ?\n"); pw = str2double(fscanf(PM100D));  % Watts

if nargin < 1, verbose = 0; end
global PM100D

RESOURCE = "USB0::0x1313::0x8070::P0000791::0::INSTR";  % from your visadevlist
VENDORS  = ["ni","keysight"];                           % try NI first, then Keysight

% If already open & alive, keep it
if ~isempty(PM100D)
    try
        if strcmp(get(PM100D,'Status'),'open') && pm100d_isAlive(PM100D)
            if verbose, disp('[PM100D] Already connected.'); end
            return
        end
    catch
        % fall through and reopen
    end
end

% Close any stale handle
try
    if ~isempty(PM100D) && strcmp(get(PM100D,'Status'),'open')
        fclose(PM100D);
    end
catch
end
PM100D = [];

lastErr = '';
for v = VENDORS
    try
        if verbose, fprintf('[PM100D] Opening %s via %s...\n', RESOURCE, v); end

        obj = visa(char(v), char(RESOURCE)); %#ok<VISA>  % VISA-USB object
        obj.Timeout = 5;                                  % seconds
        fopen(obj);

        % Ping to confirm session
        fprintf(obj,"*IDN?\n");
        idn = strtrim(fscanf(obj));
        if isempty(idn)
            error('No response to *IDN?');
        end
        if verbose, fprintf('[PM100D] %s\n', idn); end

        PM100D = obj;   % SUCCESS
        if verbose, disp('[PM100D] Connected and ready.'); end
        return

    catch ME
        lastErr = ME.message;
        try, if ~isempty(obj) && strcmp(get(obj,'Status'),'open'), fclose(obj); end, catch, end
        % try next vendor
    end
end

error('[PM100D] Could not open %s via NI/Keysight VISA. Last error: %s', RESOURCE, lastErr);
end

% ---------- helpers ----------
function tf = pm100d_isAlive(obj)
% Return true if *IDN? responds quickly (handles unplug/replug cases)
tf = false;
try
    oldTO = get(obj,'Timeout'); set(obj,'Timeout',0.7);
    fprintf(obj,"*IDN?\n");
    r = fscanf(obj);
    set(obj,'Timeout',oldTO);
    tf = ~isempty(r);
catch
    tf = false;
end
end
