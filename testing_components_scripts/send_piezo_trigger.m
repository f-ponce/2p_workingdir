% Arm the piezo for trigger move

% stop any waveform commands
Dev.WGO(1,0); 

axisName = 'Z';
Dev.SVO(axisName,1);          % closed-loop ON

% ---- Reset any lingering waveform/offset state ----
Dev.WGO(1,0);                 % stop generator
Dev.WOS(1,0);                 % zero the DC offset (important!)
Dev.WSL(1,1);                 % link table -> generator

% ---- Build a sine with the *exact* center you want ----
center_um = 215;              % your desired center
p2p_um    = 150;               % desired peak-to-peak (e.g., ±20 around center)
Npoints   = 2000;
T_sec     = 1.0;

% Note: On many E-709 builds, WAV_SIN_P's "AmplitudeOfWave" behaves like
% a peak-to-peak parameter. Use p2p_um here to match what you want.
Dev.WAV_SIN_P(1, 0, Npoints, 0, center_um, p2p_um, 0, Npoints);

% Time scale: base is 100 µs/point → WTR = T / (N*1e-4)
Dev.WTR(1, T_sec/(Npoints*1e-4), 0);
% 
% 
% Dev.WGC(1, 3);                 % run 3 cycles per trigger (easy to see)
% Dev.WGO(1, 2);                 % ARM: wait for external TTL on Trigger In
% fprintf('Armed. qWGO=%d (expect 2)\n', Dev.qWGO(1));

% Dev.WGC(1,0);                 % 0 = continuous
% Dev.WGO(1,1);                 % start
% 
% 
% % Watch position changing
% for k=1:60
%     fprintf('\rZ = %7.2f µm', Dev.qPOS(axisName)); pause(0.05);
% end
% fprintf('\nStop.\n');
% Dev.WGO(1,0);



% % arm: wait for external TTL on Pin 10
% Dev.WGO(1,2);

% fprintf('WSL=%d  WGC=%g  WTR=%g  WGO(before)=%d\n', Dev.qWSL(1), Dev.qWGC(1), Dev.qWTR(1), Dev.qWGO(1));
% 
% 
% t = dabs.ni.daqmx.Task('piezoPulseP06'); t.createDOChan('Dev1','port0/line6');
% t.start(); t.writeDigitalData(false); pause(0.02); t.writeDigitalData(true); pause(0.10); t.writeDigitalData(false);
% t.stop(); delete(t);
% 
% % check immediately after
% fprintf('WGO(after)=%d\n', Dev.qWGO(1));
% 
% for k = 1:200
%     z = Dev.qPOS(axisName);
%     fprintf('\rZ = %6.1f µm', z);
%     pause(0.05);
% end
% fprintf('\n');