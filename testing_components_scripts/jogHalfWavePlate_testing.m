function jogHalfWavePlate(targetAngle, stepDeg, direction, verbose)
% Jogs the PR50CC-driven half-wave plate stepwise and reports full turns.
%
% Usage:
%   jogHalfWavePlate(90)                     % shortest-way jog to 90°, 1° steps
%   jogHalfWavePlate(225, 0.5)               % 0.5° steps
%   jogHalfWavePlate(30, 1, 'cw')            % force clockwise to 30°
%   jogHalfWavePlate([], 1, 'ccw')           % jog 1 full CCW turn (no target)
%   jogHalfWavePlate([], 2, 'cw', 1)         % verbose, CW full turn, 2° steps
%
% Inputs:
%   targetAngle : degrees (0..360). Empty [] => do one full turn and stop.
%   stepDeg     : positive jog step in degrees (default 1).
%   direction   : 'shortest' (default for target moves), or 'cw'/'ccw'.
%   verbose     : 0/1 (default 0).
%
% Requires: global serialport handle 'powerController' from your connect fn.

if nargin < 2 || isempty(stepDeg),   stepDeg   = 1; end
if nargin < 3 || isempty(direction), direction = 'shortest'; end
if nargin < 4 || isempty(verbose),   verbose   = 0; end

assert(stepDeg > 0, 'stepDeg must be > 0');

global powerController
assert(~isempty(powerController) && isa(powerController,'serialport') && isvalid(powerController), ...
    'Connect first: call connectToHalfWavePlateMotor().');
sp = powerController;
sp.Timeout = 5;

tolDeg = 0.25;           % stop tolerance for target angle
turnTol = 0.5;           % tolerance when counting 360° turns
maxSteps = 10000;        % safety cap

% Start state
startPos = getPosition(sp);
if verbose, fprintf('[HWP] Start angle: %.3f°\n', startPos); end

% Helper to issue one jog in signed degrees and wait until ready
    function oneJog(delta)
        writeline(sp, sprintf('1PR%0.6f', delta));    % relative move
        while ~isReady(sp), pause(0.01); end
    end

% Signed shortest wrapped difference: target - current in [-180, 180]
    function d = shortDiff(target, current)
        d = mod(target - current + 180, 360) - 180;
    end

% Accumulator for revolution counting
cum = 0; prev = startPos; turnsReported = 0;

% Core loop: jog to target OR do one full turn
if isempty(targetAngle)
    % ===== Full-turn mode (no target): jog until |cum| >= 360 =====
    dirSign = +1;
    if strcmpi(direction,'ccw'), dirSign = -1; end
    if strcmpi(direction,'shortest')
        direction = 'cw'; % default to CW if not specified
    end
    for k = 1:maxSteps
        oneJog(dirSign * stepDeg);
        cur = getPosition(sp);
        % Accumulate signed shortest step
        step = shortDiff(cur, prev);
        cum  = cum + step;
        prev = cur;

        % Report each completed full turn (in either direction)
        completed = floor((abs(cum) + turnTol) / 360);
        if completed > turnsReported
            turnsReported = completed;
            fprintf('[HWP] Completed %d full turn%s (%s).\n', ...
                turnsReported, plural(turnsReported), lower(direction));
            break;  % stop after first full turn
        end
    end
    if turnsReported == 0
        warning('[HWP] Reached step cap without a full turn (cum=%.2f°).', cum);
    end
else
    % ===== Target mode: jog stepwise to specific angle =====
    target = mod(targetAngle, 360);

    for k = 1:maxSteps
        cur = getPosition(sp);
        d = shortDiff(target, cur);

        % Decide jog direction
        if strcmpi(direction,'cw')
            jog = min( max(d,  stepDeg),  stepDeg);   % force +step
        elseif strcmpi(direction,'ccw')
            jog = max( min(d, -stepDeg), -stepDeg);   % force -step
        else
            % shortest way
            if abs(d) <= stepDeg
                % final small step: use absolute move to land exactly
                writeline(sp, sprintf('1PA%0.6f', target));
                while ~isReady(sp), pause(0.01); end
                cur = getPosition(sp);
                if verbose, fprintf('[HWP] Landed at %.3f°.\n', cur); end
                break;
            end
            jog = stepDeg * sign(d);
        end

        oneJog(jog);
        newPos = getPosition(sp);

        % Update full-turn counting
        step = shortDiff(newPos, prev);
        cum  = cum + step;
        prev = newPos;
        completed = floor((abs(cum) + turnTol) / 360);
        if completed > turnsReported
            turnsReported = completed;
            fprintf('[HWP] Completed %d full turn%s while jogging.\n', ...
                turnsReported, plural(turnsReported));
            % do not break; keep heading to target
        end

        % Close enough to target?
        if abs(shortDiff(target, newPos)) <= tolDeg
            if verbose, fprintf('[HWP] Reached target %.3f°.\n', newPos); end
            break;
        end

        if k == maxSteps
            warning('[HWP] Step cap hit before reaching target (cur=%.2f°, target=%.2f°).', newPos, target);
        end
    end
end

end % function jogHalfWavePlate


% ======== helpers (reuse your serialport-safe versions) ========

function state = isReady(sp)
    writeline(sp,'1TS'); resp = readline(sp);
    if ~ischar(resp), resp = char(resp); end
    m = regexp(resp,'1TS[0-9A-Fa-f]{4}([0-9A-Fa-f]{2})','tokens','once');
    if isempty(m), state = false; return; end
    st = upper(m{1});
    state = any(strcmp(st, {'32','33','34','35'}));   % your legacy READY set
end

function pos = getPosition(sp)
    writeline(sp,'1TP?'); resp = readline(sp);
    if isempty(resp)
        writeline(sp,'1TP'); resp = readline(sp);
    end
    if ~ischar(resp), resp = char(resp); end
    % Parse number that follows 'TP'
    m = regexp(resp,'TP\s*([+-]?\d+(?:\.\d+)?)','tokens','once');
    if isempty(m), pos = NaN; else, pos = str2double(m{1}); end
end

function s = plural(n)
    if n==1, s=''; else, s='s'; end
end
