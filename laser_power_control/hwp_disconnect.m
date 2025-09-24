function hwp_disconnect()
global powerController
try
    if isa(powerController,'serialport') && isvalid(powerController), flush(powerController); end
    if isa(powerController,'serial')   && strcmp(powerController.Status,'open'), fclose(powerController); end
catch
end
clear global powerController
global powerController
powerController = [];
disp('[HWP] Disconnected.');