function REC_STOP(c,recorderIds)
%   DESCRIPTION
%   
%   Stops the data recorder and changes the state form 'waiting' or 'running' to 'configuration'.
%   A data recorder must be stopped before it's configuration can be changed.
%   Stopping the data recorder ends an ongoing recording and deactivates the set trigger.
%
%    
%   SYNTAX
%        PIdevice.REC_STOP(recorderIds)
% 
%   INPUT
%       recorderIds (char array)             The data recorder(s) to be deactivated
%            
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CallGcs_InCharArray_Function(c,mfilename,recorderIds);

end