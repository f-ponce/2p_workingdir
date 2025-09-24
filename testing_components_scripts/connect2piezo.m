% Connect to E-709 over USB 
% Francesca V. Ponce 08/2025
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters to test move the piezo (be careful, read manual)
desired_center_um    = 200;      % center position (µm)
safetyMargin_um      = 10;       % margin from hard limits for the test mocleve
test_wait_s          = 0.5;      % dwell between test moves (s)
test_time_s            = 10;     % back-and-forth test duration (s)
test_velocity_ums    = 500;      % closed-loop velocity for MOV (um/s); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 0) Controller
Controller = PI_GCS_Controller();

% 1) Enumerate devices
devs = Controller.EnumerateUSB('');
if ischar(devs)
    devlist = regexp(devs, '\r?\n', 'split'); devlist = devlist(~cellfun(@isempty, devlist));
elseif isstring(devs)
    devlist = cellstr(devs);
elseif iscell(devs)
    devlist = devs;
else
    error('Unexpected type from EnumerateUSB: %s', class(devs));
end
assert(~isempty(devlist), 'No PI USB controllers found.');

% 2) Pick E-709
idx = find(contains(devlist,'E-709','IgnoreCase',true), 1, 'first');
%assert(~isempty(idx), 'No "E-709" device found. Devices:\n%s', strjoin(devlist, newline));
entry  = strtrim(devlist{idx});
tok    = regexp(entry, 'S/?N\s*([A-Za-z0-9\-]+)', 'tokens', 'once');
assert(~isempty(tok), 'Could not parse serial from entry: "%s"', entry);
serial = tok{1};

% 3) Connect to piezo
Dev = Controller.ConnectUSB(serial);
assert(Dev.IsConnected, 'ConnectUSB succeeded but IsConnected==false');
fprintf('Connected: %s\n', Dev.qIDN());

% % 4) Axis & current position
% axesStr       = Dev.qSAI();
% availableAxes = regexp(axesStr, '[\w-]+', 'match');
% axisName      = availableAxes{1};
% fprintf(axisName)
% fprintf('Axis: %s\n', axisName);
% 
% pos = Dev.qPOS(axisName);
% fprintf('Current position: %.3f µm\n', pos);
% 
% % 5) Travel limits
% try
%     pmin = Dev.qTMN(axisName);
%     pmax = Dev.qTMX(axisName);
% catch
%     warning('qTMN/qTMX not available; using wide fallback limits.');
%     pmin = -Inf; pmax = Inf;
% end
% fprintf('Travel range: [%.3f .. %.3f] µm\n', pmin, pmax);
% 
% % 6) Closed-loop ON (so MOV is in position units)
% Dev.SVO(axisName, 1);   % enable servo (1 = ON, 0 = OFF)
% % stop any waveform commands
% Dev.WGO(1,0); 
% % Set closed-loop velocity(um/s)
% Dev.VEL(axisName, test_velocity_ums);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 7) Move the piezo
% 
% toStart  = clampToRange(0, pmin, pmax);
% toEdge   = clampToRange(pmax - safetyMargin_um, pmin, pmax);
% toCenter = clampToRange(desired_center_um, pmin, pmax);
% 
% fprintf('Move to start (%.3f µm)...\n', toStart);
% Dev.MOV(axisName, toStart);
% waitUntilOnTarget(Dev, axisName, 7); pause(test_wait_s);
% 
% fprintf('Move between %.3f and %.3f µm for %g s...\n', toStart, toEdge, test_time_s);
% t0 = tic;
% goal = toEdge;
% 
% while toc(t0) < test_time_s
%     Dev.MOV(axisName, goal);
%     waitUntilOnTarget(Dev, axisName, 7);
%     pause(test_wait_s);
%     % toggle goal
%     if goal == toEdge, goal = toStart; else, goal = toEdge; end
% end
% 
% fprintf('Return to center (%.3f µm)...\n', toCenter);
% Dev.MOV(axisName, toCenter);
% waitUntilOnTarget(Dev, axisName, 7);


% Done
Dev.CloseConnection();
fprintf('Disconnected from piezo.\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function v = clampToRange(x, xmin, xmax)
    if ~isfinite(xmin), xmin = x; end
    if ~isfinite(xmax), xmax = x; end
    v = min(max(x, xmin), xmax);
end

function waitUntilOnTarget(d, ax, tmax)
    if nargin<3, tmax=5; end
    t0 = tic; pause(0.05);
    while toc(t0) < tmax
        try
            ont = d.qONT(ax); if iscell(ont), ont = ont{1}; end
            if logical(ont), return; end
        catch
            % qONT not available? fall back to a fixed wait
        end
        pause(0.02);
    end
end