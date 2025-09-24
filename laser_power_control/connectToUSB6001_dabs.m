function NI = connectToUSB6001_dabs(AIchannels)
% Connect to NI USB-6001 (Dev2) via ScanImage's dabs.ni.daqmx (no MathWorks DAQ toolbox).
% - Creates AO task on Dev2/ao0, ao1 and sets both to 0 V.
% - If AI channels provided (e.g., 0 or 0:2), creates AI task (Differential).
% - Exposes global USB6001AnalogInputs with .inputSingleScan().

if nargin < 1 || isempty(AIchannels)
    AIchannels = [];                 % AO-only by default
end

devID = 'Dev2';                      % hardcoded device name

% Make sure ScanImage's dabs package is on the path
assert(exist('dabs.ni.daqmx.Task','class')==8, ...
    'dabs.ni.daqmx not found. addpath(genpath(<your ScanImage folder>)) first.');

% Unique suffix to avoid "Task already exists" collisions
uid = regexprep(char(java.util.UUID.randomUUID.toString),'-','_');

% ---- AO: Dev2/ao0 & ao1 to 0 V ----
NI = struct();
AO = dabs.ni.daqmx.Task(['USB6001_AO_' uid]);
AO.createAOVoltageChan(devID, 0, '', -10, 10);
AO.createAOVoltageChan(devID, 1, '', -10, 10);
AO.writeAnalogData([0 0]);           % minimal signature (portable across dabs)
NI.AO = AO;

% ---- AI: optional Differential channels ----
global USB6001AnalogInputs
USB6001AnalogInputs = [];

if ~isempty(AIchannels)
    AI = dabs.ni.daqmx.Task(['USB6001_AI_' uid]);

    % Create each AI channel (Differential, ±10 V), robust across dabs versions
    for ch = AIchannels(:).'
        ok = false;
        % Preferred (most versions): include units + terminal config
        try
            AI.createAIVoltageChan(devID, ch, '', -10, 10, 'DAQmx_Val_Volts', 'DAQmx_Val_Diff');
            ok = true;
        catch
            % Alt: physical channel string form
            try
                AI.createAIVoltageChan(sprintf('%s/ai%d', devID, ch), '', -10, 10, 'DAQmx_Val_Volts', 'DAQmx_Val_Diff');
                ok = true;
            catch
                % Legacy: no units arg, terminal config last
                try
                    AI.createAIVoltageChan(devID, ch, '', -10, 10, 'DAQmx_Val_Diff');
                    ok = true;
                catch ME3
                    error('AI channel create failed for %s ai%d: %s', devID, ch, ME3.message);
                end
            end
        end
        if ~ok, error('Failed to create AI channel ai%d on %s', ch, devID); end
    end

    % On-demand reads; no timing config needed
    USB6001AnalogInputs = USB6001AIProxy_dabs(AI, AIchannels);
end

% Keep your old global for compatibility
global pmtState
pmtState = [0 0];
end
