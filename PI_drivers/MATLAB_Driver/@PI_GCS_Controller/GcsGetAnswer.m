function [szAnswer] = GcsGetAnswer(c)
%   DESCRIPTION
%   Gets the answer to a GCS command. The answers to a GCS 
%   command  are  stored  inside  the  DLL,  where  as  much  space  as  necessary  is  obtained.  Each  call  to  this 
%   function returns and deletes the oldest answer in the DLL.
%   See the User Manual of the controller for a description of the GCS commands which are understood by 
%   the controller firmware, for a command reference and for any limitations regarding the arguments of the 
%   commands.
%
%   SYNTAX
%       PIdevice.GcsGetAnswer
% 
%   OUTPUT
%       [szAnswer] (char array)       the buffer to receive the answer
%
%   PI MATLAB Class Library Version 1.5.0      
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(c.ID<0), error('The controller is not connected'),end;
functionName = [ c.libalias, '_', mfilename];
if(any(strcmp(functionName,c.dllfunctions)))
	try
		szAnswer = blanks(100001);
		[bRet,szAnswer] = calllib(c.libalias,functionName,c.ID,szAnswer,100000);
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
