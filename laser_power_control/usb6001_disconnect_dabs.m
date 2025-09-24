function usb6001_disconnect_dabs()
% Clean up AI proxy and AO task
global USB6001AnalogInputs
try, if ~isempty(USB6001AnalogInputs), delete(USB6001AnalogInputs); end, end
USB6001AnalogInputs = [];

try
    NI = evalin('base','NI');   % if you stored the returned struct in base
    if isstruct(NI) && isfield(NI,'AO') && ~isempty(NI.AO)
        NI.AO.clear();
    end
catch
end
end
