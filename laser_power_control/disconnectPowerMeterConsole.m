function disconnectPowerMeterConsole()
global PM100D
try, if ~isempty(PM100D) && strcmp(get(PM100D,'Status'),'open'), fclose(PM100D); end, end
PM100D = [];
disp('[PM100D] Disconnected.');
end