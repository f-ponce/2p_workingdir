classdef USB6001AIProxy_dabs < handle
    properties (SetAccess=private)
        task    % dabs.ni.daqmx.Task
        chans   % numeric channel list (e.g. [0 1 2])
    end
    methods
        function obj = USB6001AIProxy_dabs(task, chans)
            obj.task  = task;
            obj.chans = chans(:).';
        end
        function v = inputSingleScan(obj)
            % One on-demand sample from each configured AI channel
            v = double(obj.task.readAnalogData(1,'scaled',1));
            v = v(:).'; % row vector
        end
        function delete(obj)
            try, obj.task.clear(); end
        end
    end
end
