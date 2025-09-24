function [iValueArray] = qATS(c,piChannels,piOptions)
%   DESCRIPTION
%   Query the results of the latest auto calibration procedure started with ATC().
%   See "Calibration Settings" in the User Manual of the controller for more information.
%
%   SYNTAX
%       [bJoystickButtons] = PIdevice.qATS(piChannels,piOptions)
% 
%   INPUT
%       piChannels (int array)                  piChannels string with channels of the piezo control electronics
%
%       piOptions (int array)                   piOptions gives the option to be queried. See PI_ATC() for details.
%
%   OUTPUT
%       [iValueArray] (int array)               piValueArray gives the results of the latest auto calibration procedure. 
%                                               If 0, the ATC() procedure was successful. Values >0 indicate option specific error codes;
%                                               multiple non-zero error codes for the 
%                                               same channel and option will be listed one after another.
%  
%   PI MATLAB Class Library Version 1.5.0    
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	nValues = length(piChannels);
	iValueArray = zeros(size(piChannels));
	piChannelIDs = libpointer('int32Ptr',piChannels);
	piOptionIDs = libpointer('int32Ptr',piOptions);
	piValueArray = libpointer('int32Ptr',iValueArray);
	try
		[bRet,~,~,iValueArray] = calllib(c.libalias,functionName,c.ID,piChannelIDs,piOptionIDs,piValueArray,nValues);
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
