function POS(c,szAxes,dValues)
%   DESCRIPTION
%   Set current position for given axis (does not cause motion). An axis is considered as "referenced" when 
%   the position was set with POS(), so that qFRF() replies "1". Setting the current position with 
%   POS() is only possible when the referencing mode is set to "0", see RON().
%   NOTICE:
%   The "software-based" travel range limits (qTMN() and qTMX()) and the "software-based" home 
%   position (qDHF()) are not adapted when a position value is set with POS(). This may result in
%   - target positions which are inside the range limits but can not be reached by the hardware—the 
%   mechanics is at the hardstop but tries to move further and must be stopped with STP()
%   - target positions which can be reached by the hardware but are outside of the range limits—e.g. the 
%   mechanics is at the negative hardstop and physically could move to the positive hardstop, but due to 
%   the software based-travel range limits the target position is not accepted and no motion is possible
%   - a home position which is outside of the travel range.
%
%   SYNTAX
%       PIdevice.POS(szAxes, dValues)
% 
%   INPUT
%       szAxes (char array)             string with axes
%
%       dValues (double array)          new axis positions in physical units
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CallGcs_InAxes_InDoubleArray_Function(c,mfilename,szAxes,dValues)
