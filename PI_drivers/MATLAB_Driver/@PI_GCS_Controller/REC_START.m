function REC_START(c,recorderIds)
%   DESCRIPTION
%
%   Changes the state of the data recorder from 'configuration' to 'waiting'.
%   In this state, the data recorder waits until the trigger occures in order to start the data recorder.
%   After this trigger, the data recorder is in the state 'run'.
%
%
%   SYNTAX
%       PIdevice.REC_START(recorderIds)
% 
%   INPUT
%       recorderIds (char array)               The data recorder(s) to be activated
%     
%   PI MATLAB Class Library Version 1.6.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


CallGcs_InCharArray_Function(c,mfilename,recorderIds);

end