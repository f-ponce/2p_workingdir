function iValues = qFRF(c,szAxes)
%   DESCRIPTION
%   Indicates whether the given axis is referenced or not.
%   An axis is considered as "referenced" when the current position value is set to a known position. 
%   Depending on the controller, this is the case if a reference move was successfully executed with FRF(), 
%   FNL() or FPL(), or if the position was set manually with POS().
%
%   For controllers with GCS3.0 syntax:
%       szAxes can only include one axis or None for all axes
%
%
%   SYNTAX
%       iValues = PIdevice.qFRF(szAxes)
% 
%   INPUT
%       szAxes (char array)         string with axes, if '' or no parameters were passed, all axes are affected
%
%   OUTPUT
%       iValues (int array)         array to receive, 1 if successful, 0 if axis is not referenced
%                                   (e.g. referencing move failed or has not finished yet)
%      
%   PI MATLAB Class Library Version 1.5.0
%   COPYRIGHT © PHYSIKINSTRUMENTE (PI) GMBH U. CO. KG, support-software@pi.ws
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargin==1)
    iValues = CallGcs_InAxesOrNone_OutInt32Array_Function(c, mfilename);
else
    iValues = CallGcs_InAxesOrNone_OutInt32Array_Function(c, mfilename, szAxes);
end    
