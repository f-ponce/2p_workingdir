function display(c)

% This code is provided by Physik Instrumente(PI) GmbH&Co.KG
% You may alter it corresponding to your needs
% Comments and Corrections are very welcome
% Please contact us by mailing to c.wurm@pi.ws

disp(sprintf('%s class object',c.libalias));
disp(sprintf('ID: %d',c.ID));
disp(sprintf('IDN: %s',c.IDN));
if(c.NumberOfAxes>0)
    disp(sprintf('%d possible axes',c.NumberOfAxes));
else
    disp(sprintf('%d possible axis',c.NumberOfAxes));
end
if(c.NumberOfAnalogInputs>0)
    disp(sprintf('%d possible analog inputs',c.NumberOfAnalogInputs));
else
    disp(sprintf('%d possible analog inputs',c.NumberOfAnalogInputs));
end
if(c.ID>-1)

    iErr = qERR(c);
    if(iErr~=0)
        disp(sprintf('Error %d occured:\n%s',iErr,TranslateError(c,iErr)));
    end

end
if(c.DC_ID>-1)

    if(~isempty(c.ConnectedDaisyChainDevices))
        for i = 1:length(c.ConnectedDaisyChainDevices)
            if(~isempty(c.ConnectedDaisyChainDevices(i)))
                disp(sprintf('DC device %d: %s',c.ConnectedDaisyChainDevices(i).Name));
            end
        end
    end
end