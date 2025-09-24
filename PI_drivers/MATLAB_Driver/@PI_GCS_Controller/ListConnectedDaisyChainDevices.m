function [listOfAvailableDevicesAsCellArray] = ListConnectedDaisyChainDevices ( c )
%function [listOfAvailableDevicesAsCellArray] = ListConnectedDaisyChainDevices ( c )
%PI MATLAB Class Library Version 1.2.0
% This code is provided by Physik Instrumente(PI) GmbH&Co.KG.
% You may alter it corresponding to your needs.
% Comments and Corrections are very welcome.
% Please contact us by mailing to support-software@pi.ws. Thank you.
listOfAvailableDevicesAsCellArray = c.ConnectedDaisyChainDevices';