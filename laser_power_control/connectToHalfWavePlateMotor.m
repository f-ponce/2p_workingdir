function connectToHalfWavePlateMotor(verbose, forceReset)
% Robust PR50CC connect using serialport (no MATLAB restart needed).
% Usage:
%   connectToHalfWavePlateMotor()            % quiet
%   connectToHalfWavePlateMotor(1)           % verbose
%   connectToHalfWavePlateMotor(1, true)     % force reset/reopen

if nargin < 1, verbose = 0; end
if nargin < 2, forceReset = false; end

COM  = 'COM4';     % change if needed
BAUD = 57600;      % try 921600 if your unit uses high baud

global powerController

% If asked to reset, or the global is invalid/different port -> drop it cleanly
if forceReset || isempty(powerController) || ~isvalidHandle(powerController, COM)
    safeCloseGlobal();
end

sp = [];  % local handle (only assign to global on success)
guard = onCleanup(@() tryClose(sp));  % ensures release on ANY error

try
    if verbose, disp('[HWP] Opening serialport...'); end
    sp = serialport(COM, BAUD, 'FlowControl',"software");
    configureTerminator(sp,"CR/LF");
    sp.Timeout = 5;
    flush(sp);

    % Ping (ignore a first-time timeout)
    writeline(sp,'VE?');
    resp = tryRead(sp);
    if verbose && ~isempty(resp), fprintf('[HWP] VE? -> %s\n', strtrim(char(resp))); end
    if isempty(resp)
        % Try alternate baud automatically
        alt = BAUD==57600; if alt, BAUD=921600; else, BAUD=57600; end
        if verbose, fprintf('[HWP] No reply @%d; trying %d...\n', alt*57600 + ~alt*921600, BAUD); end
        tryClose(sp); sp = serialport(COM, BAUD, 'FlowControl',"software");
        configureTerminator(sp,"CR/LF"); sp.Timeout = 5; flush(sp);
        writeline(sp,'VE?'); resp = tryRead(sp);
        if isempty(resp), error('No response to VE? at either baud.'); end
    end

    % Init + home only if not ready (fresh power-up)
    if ~isReady(sp)
        if verbose, disp('[HWP] Initializing / homing...'); end
        writeline(sp,'1PW1'); pause(1);
        writeline(sp,'1ZX2'); pause(2);
        writeline(sp,'1PW0'); pause(2);
        writeline(sp,'1TS'); tryRead(sp);
        writeline(sp,'1TS'); tryRead(sp);
        writeline(sp,'1OR');
        while ~isReady(sp), pause(0.05); end
        writeline(sp,'1MM1'); pause(0.5);
    end

    % Move to min-power angle
    if verbose, disp('[HWP] Moving to min-power angle...'); end
    home_position = 158.13;
    try
        S = load('C:\Users\debivort lab\Documents\MATLAB\laser_power_control\powerCalibrationData_CURRENT.mat');
        home_position = S.powerCalibrationData.theta_min;
        fprintf('[HWP] Loaded home position: %.3f deg\n', home_position);
    catch
        fprintf('[HWP] Using fallback home position: %.3f deg\n', home_position);
    end

    writeline(sp, sprintf('1PA%3.3f', home_position));
    while ~isReady(sp), pause(0.05); end

    pos = getPosition(sp);
    if ~(isfinite(pos) && abs(pos - home_position) < 2)
        warning('[HWP] Connected but position mismatch (got %.3f, expected %.3f).', pos, home_position);
    end

    % SUCCESS — publish to global and prevent auto-close
    powerController = sp;
    clear guard
    if verbose, disp('[HWP] PR50CC connected and ready.'); end

catch ME
    % Port is auto-released by guard; global left untouched
    error('[HWP] Connect failed: %s', ME.message);
end

% ======== helpers ========

function r = tryRead(sp)
    r = '';
    try
        r = readline(sp);
    catch
        r = '';
    end

function tf = isReady(sp)
    writeline(sp,'1TS'); resp = tryRead(sp);
    if ~ischar(resp), resp = char(resp); end
    m = regexp(resp,'1TS[0-9A-Fa-f]{4}([0-9A-Fa-f]{2})','tokens','once');
    if isempty(m), tf = false; return; end
    st = upper(m{1});
    tf = any(strcmp(st, {'32','33','34','35'}));  % your legacy ready set

function pos = getPosition(sp)
    writeline(sp,'1TP?'); resp = tryRead(sp);
    if isempty(resp), writeline(sp,'1TP'); resp = tryRead(sp); end
    if ~ischar(resp), resp = char(resp); end
    m = regexp(resp,'TP\s*([+-]?\d+(?:\.\d+)?)','tokens','once');
    if isempty(m), pos = NaN; else, pos = str2double(m{1}); end

function tryClose(sp)
    try
        if ~isempty(sp) && isvalid(sp)
            flush(sp);
        end
    catch
    end
    try, clear sp; catch, end

function tf = isvalidHandle(h, port)
    tf = false;
    try
        tf = isa(h,'serialport') && isvalid(h) && strcmpi(h.Port, port);
    catch
        tf = false;
    end

function safeCloseGlobal()
    global powerController
    try
        if isa(powerController,'serialport') && isvalid(powerController)
            flush(powerController);
        elseif isa(powerController,'serial') && strcmp(powerController.Status,'open')
            fclose(powerController);
        end
    catch
    end
    clear global powerController
    global powerController
    powerController = [];
