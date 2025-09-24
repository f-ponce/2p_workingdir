clear classes; rehash toolboxcache

% --- construct controller object ---
lsc = scanimage.components.motors.legacy.ESP301('comPort',6,'axis','1','baud',921600);

% Quick sanity with the new public wrappers:
lsc.command('1MO')     % motor on
lsc.command('1TJ1')    % trapezoid trajectory
lsc.query('1MD?')      % expect '1' if idle, '0' while moving
p0 = lsc.positionAbsolute(1);
lsc.moveTimeout = 20;  % give plenty of time while testing
lsc.moveCompleteAbsolute(p0 + 0.5);
lsc.query('1MD?')      % should return '1' after the move
lsc.query('TE?')       % last error (0 means OK)
lsc.query('TB?')       % error queue, if any

% --- clean up when done ---
delete(lsc);
clear lsc