function [iVal] = qFSS(c)
%   DESCRIPTION
%   Gets the status of the last scanning procedure that was started. 
%   In order to check whether a scanning procedure is still going on, the motion status of the axes can be 
%   queried with IsMoving().
%   qFSS() gets the status of scanning procedures that are started with the following commands:
%   AAP(), FIO(), FLM(), FLS(), FSA(), FSC(), FSM()
%
%   SYNTAX
%       [iVal] = PIdevice.qFSS
% 
%   OUTPUT
%       [iVal] (int)            indicates the status of the last scanning procedure that was started.
%                                   1: Scanning procedure has been successfully completed
%                                   0: Scanning procedure is still going on or has been unsuccessfully completed.
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	iVal = 1;
	piValue = libpointer('int32Ptr',iVal);
	try
		[bRet,iVal] = calllib(c.libalias,functionName,c.ID,piValue);
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
