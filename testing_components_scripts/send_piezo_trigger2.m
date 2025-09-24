function prove_trigger_gate_plot()
% E-709 gate proof WITH PLOT
% LOW (no motion) -> HIGH (motion) -> LOW (stop)
% WIRING (must be two wires):
%   NI Dev1/port0/line6  --> E-709 Trigger-In (Digital_IN_1)
%   NI DGND              --> E-709 GND/AGND
%
% Run:  prove_trigger_gate_plot

%% -------- user knobs --------
niDev   = 'Dev1';
niLine  = 'port0/line6';

center_um = 215;      % your center
p2p_um    = 150;      % big span (±75 um)
T_sec     = 1.0;      % 1 s period
Npoints   = 2000;
safetyMargin_um = 5;

seg_low1_s  = 2.0;    % LOW segment (baseline)
seg_high_s  = 3.3;    % HIGH segment (>= ~3*T to see clear motion)
seg_low2_s  = 2.0;    % LOW segment (stop)
sample_dt   = 0.01;   % 100 Hz sampling for plotting

%% -------- connect to E-709 --------
Controller = PI_GCS_Controller();
devs = Controller.EnumerateUSB('');
if ischar(devs)
    L = regexp(devs,'\r?\n','split'); L = L(~cellfun(@isempty,L));
elseif isstring(devs)
    L = cellstr(devs);
else
    L = devs;
end
assert(~isempty(L),'No PI USB controllers found.');
idx = find(contains(L,'E-709','IgnoreCase',true),1,'first'); if isempty(idx), idx=1; end
serialTok = regexp(strtrim(L{idx}),'S/?N\s*([A-Za-z0-9\-]+)','tokens','once');
assert(~isempty(serialTok),'Could not parse serial from: "%s"', L{idx});
Dev = Controller.ConnectUSB(serialTok{1}); assert(Dev.IsConnected);

axesStr = Dev.qSAI(); ax = regexp(axesStr,'[\w-]+','match');
axisName = ax{1};
fprintf('Connected: %s | Axis=%s | POS=%.2f µm\n', Dev.qIDN(), axisName, Dev.qPOS(axisName));

%% -------- stop & safety --------
try, Dev.WGO(1,0); catch, end
try, Dev.STP();    catch, end
Dev.SVO(axisName,1);

try
    pmin = Dev.qTMN(axisName); pmax = Dev.qTMX(axisName);
catch
    pmin = -inf; pmax = +inf;
end
usable_min = pmin + safetyMargin_um; usable_max = pmax - safetyMargin_um;
p2p_um = min(p2p_um, max(0, usable_max - usable_min));
center_um = min(max(center_um, usable_min + p2p_um/2), usable_max - p2p_um/2);

WTR = T_sec/(Npoints*1e-4); assert(WTR>=1,'WTR<1; increase T_sec or reduce Npoints.');
fprintf('Sweep: center=%.1f µm, p2p=%.1f µm  -> [%.1f .. %.1f]\n', ...
    center_um, p2p_um, center_um-p2p_um/2, center_um+p2p_um/2);

%% -------- program sine & ARM --------
Dev.WGO(1,0); Dev.WOS(1,0); Dev.WSL(1,1);
Dev.WAV_SIN_P(1, 0, Npoints, 0, center_um, p2p_um, 0, Npoints);
Dev.WTR(1, WTR, 0);
Dev.WGC(1, 0);          % 0 = continuous; gate controls run/stop
Dev.WGO(1, 2);          % ARMED (wait for external input)
fprintf('Armed: qWGO=%d (expect 2)\n', Dev.qWGO(1));

%% -------- DO task (P0.6) --------
tDO = dabs.ni.daqmx.Task('gateP06'); 
tDO.createDOChan(niDev, niLine); 
tDO.start();

%% -------- record + gate pattern --------
total_s = seg_low1_s + seg_high_s + seg_low2_s;
N = ceil(total_s / sample_dt) + 10;
tt = nan(1,N); zz = nan(1,N); gg = nan(1,N); ww = nan(1,N);
k = 0; t0 = tic;

% start LOW baseline (expect no motion)
tDO.writeDigitalData(false); pause(0.02);
t1 = tic;
while toc(t1) < seg_low1_s
    k = k+1; tt(k)=toc(t0); zz(k)=Dev.qPOS(axisName); ww(k)=Dev.qWGO(1); gg(k)=0;
    pause(sample_dt);
end

% go HIGH (expect motion while HIGH)
tDO.writeDigitalData(true); pause(0.02);
t2 = tic;
while toc(t2) < seg_high_s
    k = k+1; tt(k)=toc(t0); zz(k)=Dev.qPOS(axisName); ww(k)=Dev.qWGO(1); gg(k)=1;
    pause(sample_dt);
end

% back LOW (expect stop)
tDO.writeDigitalData(false); pause(0.02);
t3 = tic;
while toc(t3) < seg_low2_s
    k = k+1; tt(k)=toc(t0); zz(k)=Dev.qPOS(axisName); ww(k)=Dev.qWGO(1); gg(k)=0;
    pause(sample_dt);
end

% trim
tt = tt(1:k); zz = zz(1:k); gg = gg(1:k); ww = ww(1:k);

%% -------- plot --------
figure('Name','E-709 Gate Proof','Color','w');
subplot(2,1,1);
plot(tt, zz, 'LineWidth', 1.5);
xlabel('Time (s)'); ylabel('Z (µm)');
title('Z vs time — expect motion only while gate = HIGH');
grid on;

subplot(2,1,2);
stairs(tt, gg, 'LineWidth', 1.6); hold on;
stairs(tt, (ww==1), '--', 'LineWidth', 1.0);   % some firmwares keep WGO=2 during level gate; Z is the truth
ylim([-0.2 1.2]); yticks([0 1]); yticklabels({'LOW','HIGH'});
xlabel('Time (s)'); ylabel('Gate / WGO');
legend({'Gate (P0.6)','(optional) WGO==1'}, 'Location','best');
grid on;

%% -------- cleanup --------
try, Dev.WGO(1,0); catch, end
tDO.stop(); delete(tDO);
Dev.CloseConnection(); fprintf('Done.\n');
end
