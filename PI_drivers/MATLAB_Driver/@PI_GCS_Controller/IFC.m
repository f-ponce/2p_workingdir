function IFC(c,sParameters,sValues)
%   DESCRIPTION
%   Interface configuration.
%   After IFC() is sent, the new setting becomes active and the host PC interface
%   configuration may need to be changed to maintain communication.
%
%   SYNTAX
%       PIdevice.IFC(sParameters,sValues)
% 
%   INPUT
%       sParameters (char array)        determines which interface <parameter> should be changed. See sValues.
%    
%       sValues (char array)            Array with the values of the parameters:
%                                       for szParameters  = RSBAUD, the szValues parameter value gives the baud rate to be used 
%                                           for RS-232 communication
%                                       for szParameters  = GPADR, the szValues parameter value gives the device address to be 
%                                           used for GPIB (IEEE 488) communication
%                                       for szParameters  = IPADR, the first four portions of the szValues parameter value specify 
%                                           the default IP address for TCP/IP communication, the last portion specifies the default 
%                                           port to be used
%                                       for szParameters  = IPSTART, the szValues parameter value defines the startup behavior for 
%                                           configuration of the IP address for TCP/IP communication:
%                                           0 = use IP address defined with IPADR
%                                           1 = use DHCP to obtain IP address, if this fails, use IPADR
%                                       for szParameters  = IPMASK, the szValues parameter value gives the IP mask to be used for 
%                                           TCP/IP communication, in the form uint.uint.uint.uint
%
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		[bRet] = calllib(c.libalias,functionName,c.ID,sParameters,sValues);
		if(bRet==0)
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
