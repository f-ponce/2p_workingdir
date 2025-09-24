function ATZ(c, szAxesIdentifierArray, lowVoltageArray)
%   DESCRIPTION
%   Automatic zero-point calibration for szAxesIdentifierArray. Sets the output 
%   voltage which is to be applied at the zero position of the axis and starts
%   an appropriate calibration procedure.
%   NOTICE: The AutoZero procedure will move the axis, and the motion may cover
%   the whole travel range. Make sure that it is safe for the positioner to move.
%   See "AutoZero Procedure" and the description of the ATZ command in the User
%   Manual of the controller for more information.
%
%   SYNTAX
%       PIdevice.ATZ(szAxes)
%       PIdevice.ATZ(szAxes, lowVoltageArray)
%
%   INPUT
%       szAxesIdentifierArray (char array)  	String with axes
%
%       lowVoltageArray (double array)          Array with low voltages for the corresponding
%                                               axes. If this parameter is omitted, the value
%                                               stored in the controller (Autozero Low Voltage
%                                               parameter, ID 0x07000A00) is used.
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Settings


%% Function arguments handle
szAxesIdentifierArray = ConvertCellArrayStringToString (szAxesIdentifierArray);
numberOfAxes = GetNrAxesInString(c, szAxesIdentifierArray);

if nargin<3
    useDefaultArray = ones(numberOfAxes, 1);
    lowVoltageArray = zeros(numberOfAxes, 1);
else
    useDefaultArray = zeros(numberOfAxes, 1);
    
    if (numberOfAxes ~= length(lowVoltageArray))
        error('The two input arguments do not have the same length. "axesIdentifierArray" and "lowVoltageArray" must have the same length or "lowVoltageArray" must be omitted in (see help for ATZ).');
    end
end


%% Check input parameters


%%  Program start

functionName = [ c.libalias, '_', mfilename];

if (any(strcmp(functionName,c.dllfunctions)))
    pdLowVoltageArray = libpointer('doublePtr',lowVoltageArray);
    pbUseDefaultArray = libpointer('int32Ptr',useDefaultArray);
    try
        [bRet] = calllib(c.libalias,functionName, c.ID, ...
            szAxesIdentifierArray,pdLowVoltageArray,pbUseDefaultArray);
        if (bRet == 0)
            iError = GetError(c);
            szDesc = TranslateError(c,iError);
            error(szDesc);
        end
    catch
        rethrow(lasterror);
    end
else
    error('%s not found',functionName);
end